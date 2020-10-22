//
//  Section.swift
//  TableKit
//
//  Created by Shvier on 2020/10/21.
//  Copyright © 2020 Shvier. All rights reserved.
//

import UIKit

class Section<T: UITableViewHeaderFooterView>: Node, UITableViewReusableSection {
    
    var itemType: AnyClass {
        return T.self
    }
    
    var itemHeight: CGFloat {
        return UITableView.automaticDimension
    }
    
    var item: T!
    
    // MARK: - Lifecycle
    
    func tableView(_ tableView: UITableView, isDisplaying view: T, in section: Int) {
        
    }
    
    func dequeueReusableView(in tableView: UITableView, in section: Int) -> UITableViewHeaderFooterView {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier) as! T
        self.item = view
        self.tableView(tableView, isDisplaying: view, in: section)
        return view
    }
    
}
