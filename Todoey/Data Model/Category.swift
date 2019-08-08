//
//  Category.swift
//  Todoey
//
//  Created by Hakan Kaya on 7.08.2019.
//  Copyright © 2019 Hakan Kaya. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var colour: String = ""
    let items = List<Item>()
}
