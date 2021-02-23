//
//  Row.swift
//  TableKit
//
//  Created by Shvier on 2020/9/17.
//  Copyright © 2020 Shvier. All rights reserved.
//

import UIKit

public protocol Reusable {
    
    var itemType: AnyClass { get }
    var reuseIdentifier: String { get }
    
}

extension Reusable {
    
    public   var reuseIdentifier: String {
        return String(describing: itemType)
    }

}
