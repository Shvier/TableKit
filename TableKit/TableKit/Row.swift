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
    
    mutating func dequeueReusableCell(in tableView: UITableView, at indexPath: IndexPath) -> Item
    func tableView(_ tableView: UITableView, isDisplaying cell: Item, at indexPath: IndexPath)
    
}

extension Row {
    
    var cellType: UITableViewCell.Type {
        return Item.self
    }
    
    var reuseIdentifier: String {
        return String(describing: cellType)
    }
    
    mutating func dequeueReusableCell(in tableView: UITableView, at indexPath: IndexPath) -> Item {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! Item
        self.cell = cell
        self.tableView(tableView, isDisplaying: cell, at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, isDisplaying cell: Item, at indexPath: IndexPath) {
        
    }
    
}
