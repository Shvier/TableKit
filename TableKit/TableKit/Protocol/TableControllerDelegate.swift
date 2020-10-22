//
//  TableControllerDelegate.swift
//  TableKit
//
//  Created by Shvier on 2020/10/22.
//  Copyright © 2020 Shvier. All rights reserved.
//

import UIKit

protocol TableControllerDelegate: class {
    
    func didSelectRow(_ row: Row<UITableViewCell>)
    func willDisplayRow(_ row: Row<UITableViewCell>)
    func didEndDisplayRow(_ row: Row<UITableViewCell>)
    
}

extension TableControllerDelegate {
    
    func didSelectRow(_ row: Row<UITableViewCell>) {}
    func willDisplayRow(_ row: Row<UITableViewCell>) {}
    func didEndDisplayRow(_ row: Row<UITableViewCell>) {}
    
}
