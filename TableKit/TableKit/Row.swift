//
//  TableRow.swift
//  TableKit
//
//  Created by Shvier on 2020/10/21.
//  Copyright © 2020 Shvier. All rights reserved.
//

import UIKit

open class Row<T: UITableViewCell>: Node, UITableViewReusableCell {
    
    var item: T?
    
    public var itemType: AnyClass {
        return T.self
    }
    
    public var itemHeight: CGFloat {
        return UITableView.automaticDimension
    }
    
    public var didClickRow: (() -> Void)?
    
    // MARK: - Lifecycle
    
    func tableView(_ tableView: UITableView, isDisplaying cell: T, at indexPath: IndexPath) {
        
    }
    
    public func dequeueReusableCell(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! T
        self.item = cell
        self.tableView(tableView, isDisplaying: cell, at: indexPath)
        return cell
    }
    
    func didSelectRow(in tableView: UITableView, at indexPath: IndexPath) {
        didClickRow?()
    }
    
}
