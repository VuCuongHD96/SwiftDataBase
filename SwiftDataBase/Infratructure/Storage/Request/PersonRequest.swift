//
//  PersonRequest.swift
//  SwiftDataBase
//
//  Created by Work on 15/6/24.
//

import SwiftData

struct PersonRequest: SwiftDataBaseRequestType {
    typealias T = PersonStorage
    var request: FetchDescriptor<T>
    
    init() {
        self.request = FetchDescriptor<T>()
    }
}
