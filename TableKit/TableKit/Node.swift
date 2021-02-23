//
//  Node.swift
//  TableKit
//
//  Created by Shvier on 2020/10/21.
//  Copyright © 2020 Shvier. All rights reserved.
//

import Foundation

open class Node: NSObject {
    
    weak var parent: Node?
    weak var previous: Node?
    weak var next: Node?
    
}
