//
//  Category.swift
//  iOSMidterm
//
//  Created by Stephen Cheng on 2017-10-23.
//  Copyright © 2017 Stephen Cheng. All rights reserved.
//

import UIKit

class Category {
    var name: String
    var description: String
    var notes: [Note]
    init(name: String, description: String) {
        self.name = name
        self.description = description
        self.notes = [Note]()
    }
}
