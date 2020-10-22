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
    
    private(set) var sections: [Section<UITableViewHeaderFooterView>] = []
    private(set) var rows: [[Row<UITableViewCell>]] = []
    private var rowIndexesOnScreen: [[Int]] = []
    
    // MARK: - Operation
    
    func append(section: Section<UITableViewHeaderFooterView>) {
        register(section: section)
        section.previous = sections.last
        section.parent = self
        sections.append(section)
        rows.append([Row<UITableViewCell>]())
    }
    
    func append(row: Row<UITableViewCell>) {
        register(row: row)
        if let lastSection = sections.last {
            row.parent = lastSection
        } else {
            let section = Section<UITableViewHeaderFooterView>()
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
        return indexes
    }
    
    func updateDiffableDataSource(forSections sections: inout [Section<UITableViewHeaderFooterView>], rows: inout [[Row<UITableViewCell>]]) {
        
    }
    
    // MARK: - Configuration
    
    private func configureUI() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func register(section: Section<UITableViewHeaderFooterView>) {
        let reuseIdentifier = section.reuseIdentifier
        guard !sectionReusePool.contains(reuseIdentifier) else {
            return
        }
        sectionReusePool.update(with: reuseIdentifier)
        tableView.register(section.itemType, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
    }
    
    private func register(row: Row<UITableViewCell>) {
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
        return sections[section].dequeueReusableView(in: tableView, in: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sections[section].height
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
        return row.height
    }
    
}
