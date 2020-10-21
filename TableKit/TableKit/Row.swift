//
//  TableRow.swift
//  TableKit
//
//  Created by Shvier on 2020/10/21.
//  Copyright © 2020 Shvier. All rights reserved.
//

import UIKit

class Row<T: UITableViewCell>: Node, ReusableProtocol {
    
    typealias Item = T
    
    var item: T!
    
    // MARK: - Lifecycle
    
    func tableView(_ tableView: UITableView, isDisplaying cell: Item, at indexPath: IndexPath) {
        
    }
    
    // MARK: - Private
    
    private func dequeueReusableCell(in tableView: UITableView, at indexPath: IndexPath) -> Item {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! Item
        self.item = cell
        self.tableView(tableView, isDisplaying: cell, at: indexPath)
        return cell
    }
    
}
