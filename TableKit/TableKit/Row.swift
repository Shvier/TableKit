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
    
    var height: CGFloat {
        guard viewSize.height > 0 else {
            return UITableView.automaticDimension
        }
        return viewSize.height
    }
    
    var didClickRow: (() -> Void)?
    
    // MARK: - Lifecycle
    
    func tableView(_ tableView: UITableView, isDisplaying cell: Item, at indexPath: IndexPath) {
        
    }
    
    func dequeueReusableCell(in tableView: UITableView, at indexPath: IndexPath) -> Item {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! Item
        self.item = cell
        self.tableView(tableView, isDisplaying: cell, at: indexPath)
        return cell
    }
    
    func didSelectRow(in tableView: UITableView, at indexPath: IndexPath) {
        didClickRow?()
    }
    
}
