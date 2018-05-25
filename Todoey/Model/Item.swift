//
//  Item.swift
//  Todoey
//
//  Created by Eric Tran on 5/24/18.
//  Copyright © 2018 Eric Tran. All rights reserved.
//

import Foundation

class Item {
    
    init(task: String, isChecked: Bool) {
        self.task = task
        self.isChecked = isChecked
    }
    
    var task: String = ""
    var isChecked: Bool = false
}
