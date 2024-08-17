//
//  ModelContainerMaker.swift
//  SwiftDataBase
//
//  Created by Work on 17/8/24.
//

import SwiftData

struct ModelContainerMaker {
    
    static func make() throws -> ModelContainer {
        try ModelContainer(
            for: PersonStorage.self, SchoolStorage.self
        )
    }
}
