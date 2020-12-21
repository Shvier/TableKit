//
//  TableController.swift
//  TableKit
//
//  Created by Shvier on 2020/10/21.
//  Copyright © 2020 Shvier. All rights reserved.
//

import UIKit

class TableController: Node {
    
    let tableView: UITableView
    
    init(style: UITableView.Style) {
        tableView = UITableView(frame: .zero, style: style)
    }
    
    private var sectionReusePool = Set<String>()
    private var rowReusePool = Set<String>()
    
    private(set) var sections: [Node & UITableViewReusableSection] = []
    private(set) var rows: [[Node & UITableViewReusableCell]] = []
    private var rowIndexesOnScreen: [[Int]] = []
    
    weak var delegate: TableControllerDelegate?
    
    // MARK: - Operation
    
    func append(section: Node & UITableViewReusableSection) {
        register(section: section)
        section.previous = sections.last
        section.parent = self
        sections.append(section)
        rows.append([Row<UITableViewCell>]())
    }
    
    func append(row: Node & UITableViewReusableCell) {
        register(row: row)
        if let lastSection = sections.last {
            if let next = lastSection.next {
                row.previous = next
            } else {
                lastSection.next = row
            }
            row.parent = lastSection
        } else {
            let section = Section<UITableViewHeaderFooterView>()
            register(section: section)
            section.next = row
            sections.append(section)
            row.parent = section
        }
        guard var lastGroupRows = rows.popLast() else {
            rows.append([row])
            return
        }
        row.previous = lastGroupRows.last
        lastGroupRows.last?.next = row
        lastGroupRows.append(row)
        rows.append(lastGroupRows)
    }
    
    func removeAll() {
        sections.removeAll()
        rows.removeAll()
        rowIndexesOnScreen.removeAll()
    }
    
    func remove(row: Node & UITableViewReusableCell) {
        for sectionIndex in 0..<rows.count {
            var rowGroup = rows[sectionIndex]
            guard let rowIndex = rowGroup.firstIndex(where: { $0 === row}) else {
                continue
            }
            row.previous?.next = row.next
            row.next?.previous = row.previous
            if rowIndex == 0 {
                row.parent?.next = row.next
            }
            rowGroup.remove(at: rowIndex)
            rows[sectionIndex] = rowGroup
            rowIndexesOnScreen[sectionIndex] = reloadRowIndexes(atSection: sectionIndex)
            tableView.beginUpdates()
            tableView.deleteRows(at: [IndexPath(row: rowIndex, section: sectionIndex)], with: .automatic)
            tableView.endUpdates()
            return
        }
    }
    
    func reloadData() {
        rowIndexesOnScreen = sections.enumerated().map({ (index, _) -> [Int] in
            return reloadRowIndexes(atSection: index)
        })
        tableView.reloadData()
    }
    
    func reloadSections(_ indexSet: IndexSet) {
        indexSet.forEach { (index) in
            rowIndexesOnScreen[index] = reloadRowIndexes(atSection: index)
        }
        tableView.reloadSections(indexSet, with: .automatic)
    }
    
    func reloadRows(at indexPaths: [IndexPath]) {
        tableView.reloadRows(at: indexPaths, with: .automatic)
    }
    
    func reloadRowIndexes(atSection index: Int) -> [Int] {
        updateDiffableDataSource(forSections: &sections, rows: &rows)
        let section = sections[index]
        section.updateSectionState()
        guard let startRow = section.next else {
            return []
        }
        var iterator: Node? = nil
        iterator = startRow
        let subRows = rows[index]
        var indexes = [Int]()
        while iterator != nil {
            if let itrIndex = subRows.firstIndex(where: { $0 === iterator }) {
                indexes.append(itrIndex)
            }
            iterator = iterator?.next
        }
        return indexes.enumerated().map { (index, _) -> Int in
            return index
        }
    }
    
    func updateDiffableDataSource(forSections sections: inout [Node & UITableViewReusableSection], rows: inout [[Node & UITableViewReusableCell]]) {
        
    }
    
    // MARK: - Configuration
    
    private func configureUI() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func register(section: Node & UITableViewReusableSection) {
        let reuseIdentifier = section.reuseIdentifier
        guard !sectionReusePool.contains(reuseIdentifier) else {
            return
        }
        sectionReusePool.update(with: reuseIdentifier)
        tableView.register(section.itemType, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
    }
    
    private func register(row: Node & UITableViewReusableCell) {
        let reuseIdentifier = row.reuseIdentifier
        guard !rowReusePool.contains(reuseIdentifier) else {
            return
        }
        rowReusePool.update(with: reuseIdentifier)
        tableView.register(row.itemType, forCellReuseIdentifier: reuseIdentifier)
    }
    
}

extension TableController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Section
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionNode = sections[section]
        guard !sectionNode.isKind(of: Section<UITableViewHeaderFooterView>.self) else {
            return nil
        }
        return sectionNode.dequeueReusableView(in: tableView, in: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sections[section].itemHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return sections[section].itemHeight
    }
    
    // MARK: - Row
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowIndexesOnScreen[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowIndex = rowIndexesOnScreen[indexPath.section][indexPath.row]
        let row = rows[indexPath.section][rowIndex]
        return row.dequeueReusableCell(in: tableView, at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowIndex = rowIndexesOnScreen[indexPath.section][indexPath.row]
        let row = rows[indexPath.section][rowIndex]
        return row.itemHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowIndex = rowIndexesOnScreen[indexPath.section][indexPath.row]
        let row = rows[indexPath.section][rowIndex]
        return row.itemHeight
    }
    
    // MARK: -
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let rowIndex = rowIndexesOnScreen[indexPath.section][indexPath.row]
        let row = rows[indexPath.section][rowIndex]
        guard let didClickRow = row.didClickRow else {
            delegate?.didSelectRow(row)
            return
        }
        didClickRow()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.section < rowIndexesOnScreen.count && indexPath.row < rowIndexesOnScreen[indexPath.section].count else {
            return
        }
        let rowIndex = rowIndexesOnScreen[indexPath.section][indexPath.row]
        let row = rows[indexPath.section][rowIndex]
        delegate?.willDisplayRow(row)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.section < rowIndexesOnScreen.count && indexPath.row < rowIndexesOnScreen[indexPath.section].count else {
            return
        }
        let rowIndex = rowIndexesOnScreen[indexPath.section][indexPath.row]
        let row = rows[indexPath.section][rowIndex]
        delegate?.didEndDisplayRow(row)
    }
    
}
