//
//  Person.swift
//  SwiftDataBase
//
//  Created by Work on 14/8/24.
//

import Foundation

class Person {
    
    var id: String
    var name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    init(name: String) {
        id = UUID().uuidString
        self.name = name
    }
}
