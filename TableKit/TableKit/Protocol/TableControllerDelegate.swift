//
//  TableControllerDelegate.swift
//  TableKit
//
//  Created by Shvier on 2020/10/22.
//  Copyright © 2020 Shvier. All rights reserved.
//

import UIKit

public protocol TableControllerDelegate: class {
    
    func didSelectRow(_ row: Node & UITableViewReusableCell)
    func willDisplayRow(_ row: Node & UITableViewReusableCell)
    /// the row is not reliable when reload tableView because tableView(_,didEndDisplaying:) has been called after rows changed
    /// use it just for scrolling tableView and for reloading tableView, use deinit of row
    /// - Parameter row: row will disappear
    func didEndDisplayRow(_ row: Node & UITableViewReusableCell)
    
}

extension TableControllerDelegate {
    
    func didSelectRow(_ row: Node & UITableViewReusableCell) {}
    func willDisplayRow(_ row: Node & UITableViewReusableCell) {}
    func didEndDisplayRow(_ row: Node & UITableViewReusableCell) {}
    
}
