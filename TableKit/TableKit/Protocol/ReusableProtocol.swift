//
//  Row.swift
//  TableKit
//
//  Created by Shvier on 2020/9/17.
//  Copyright © 2020 Shvier. All rights reserved.
//

import UIKit

protocol ReusableProtocol {
    
    associatedtype Item: UITableViewCell
    
    var item: Item! { get set }
    var itemType: Item.Type { get }
    var reuseIdentifier: String { get }
    
}

extension ReusableProtocol {
    
    var itemType: Item.Type {
        return Item.self
    }
    
    var reuseIdentifier: String {
        return String(describing: itemType)
    }
    
}
