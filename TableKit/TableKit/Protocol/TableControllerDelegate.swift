//
//  TableControllerDelegate.swift
//  TableKit
//
//  Created by Shvier on 2020/10/22.
//  Copyright © 2020 Shvier. All rights reserved.
//

import UIKit

protocol TableControllerDelegate: class {
    
    func didSelectRow(_ row: Node & UITableViewReusableCell)
    func willDisplayRow(_ row: Node & UITableViewReusableCell)
    func didEndDisplayRow(_ row: Node & UITableViewReusableCell)
    
}

extension TableControllerDelegate {
    
    func didSelectRow(_ row: Node & UITableViewReusableCell) {}
    func willDisplayRow(_ row: Node & UITableViewReusableCell) {}
    func didEndDisplayRow(_ row: Node & UITableViewReusableCell) {}
    
}
