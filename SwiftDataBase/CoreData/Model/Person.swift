//
//  Person.swift
//  SwiftDataBase
//
//  Created by Work on 15/6/24.
//

import Foundation
import SwiftData

@Model
class Person: Identifiable {
    
    var id = UUID().uuidString
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
