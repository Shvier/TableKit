//
//  Row.swift
//  TableKit
//
//  Created by Shvier on 2020/9/17.
//  Copyright © 2020 Shvier. All rights reserved.
//

import UIKit

protocol Row {
    
    associatedtype Item: UITableViewCell
    
    var cell: Item! { get set }
    var cellType: UITableViewCell.Type { get }
    var reuseIdentifier: String { get }
    
    func dequeueReusableCell(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
    func cellIsDisplaying(in tableView: UITableView, at indexPath: IndexPath, cell: UITableViewCell)
    
}

extension Row {
    
    var cellType: UITableViewCell.Type {
        return Item.self
    }
    
    var reuseIdentifier: String {
        return String(describing: cellType)
    }
    
    func dequeueReusableCell(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! Item
        self.cell = cell
        cellIsDisplaying(in: tableView, at: indexPath, cell: cell)
        return cell
    }
    
    func cellIsDisplaying(in tableView: UITableView, at indexPath: IndexPath, cell: UITableViewCell) {
        
    }
    
}
