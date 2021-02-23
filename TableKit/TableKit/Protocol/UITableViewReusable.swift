//
//  UITableViewReusable.swift
//  TableKit
//
//  Created by Shvier on 2020/10/22.
//  Copyright © 2020 Shvier. All rights reserved.
//

import UIKit

public protocol UITableViewReusable: Reusable {
    
    var itemHeight: CGFloat { get }
        
}

extension UITableViewReusable {
    
    var itemHeight: CGFloat {
        return UITableView.automaticDimension
    }
    
}

public protocol UITableViewReusableCell: UITableViewReusable {
    
    var didClickRow: (() -> Void)? { get set }

    func dequeueReusableCell(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
    
}

public protocol UITableViewReusableSection: UITableViewReusable {

    func dequeueReusableView(in tableView: UITableView, in section: Int ) -> UITableViewHeaderFooterView
    func updateSectionState()
    
}
