//
//  UITableViewReusable.swift
//  TableKit
//
//  Created by Shvier on 2020/10/22.
//  Copyright © 2020 Shvier. All rights reserved.
//

import UIKit

protocol UITableViewReusable: Reusable {
    
    var itemHeight: CGFloat { get }
        
}

extension UITableViewReusable {
    
    var itemHeight: CGFloat {
        return UITableView.automaticDimension
    }
    
}

protocol UITableViewReusableCell: UITableViewReusable {
    
    var didClickRow: (() -> Void)? { get set }

    func dequeueReusableCell(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
    
}

protocol UITableViewReusableSection: UITableViewReusable {

    func dequeueReusableView(in tableView: UITableView, in section: Int ) -> UITableViewHeaderFooterView
    
}
