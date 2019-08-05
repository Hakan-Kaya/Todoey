//
//  Item.swift
//  Todoey
//
//  Created by Hakan Kaya on 5.08.2019.
//  Copyright © 2019 Hakan Kaya. All rights reserved.
//

import Foundation

class Item {
    
    var title: String = ""
    var done: Bool = false
    
    init(title: String, done: Bool) {
        self.title = title
        self.done = done
    }
}
