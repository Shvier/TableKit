//
//  Section.swift
//  TableKit
//
//  Created by Shvier on 2020/10/21.
//  Copyright © 2020 Shvier. All rights reserved.
//

import UIKit

class Section<T: UITableViewHeaderFooterView>: Node, ReusableProtocol {
    
    typealias Item = T
    
    var item: T!
    
    var height: CGFloat {
        guard viewSize.height > 0 else {
            return UITableView.automaticDimension
        }
        return viewSize.height
    }
    
    // MARK: - Lifecycle
    
    func tableView(_ tableView: UITableView, isDisplaying view: Item, in section: Int) {
        
    }
    
    func dequeueReusableView(in tableView: UITableView, in section: Int ) -> Item {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier) as! Item
        self.item = view
        self.tableView(tableView, isDisplaying: view, in: section)
        return view
    }
    
}
