//
//  PersonRequest.swift
//  SwiftDataBase
//
//  Created by Work on 15/6/24.
//

import SwiftData

struct PersonRequest: SwiftDataBaseRequestType {
    typealias T = Person
    var request: FetchDescriptor<Person>
    
    init() {
        self.request = FetchDescriptor<Person>()
    }
}
