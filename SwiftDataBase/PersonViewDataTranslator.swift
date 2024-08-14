//
//  PersonViewDataTranslator.swift
//  SwiftDataBase
//
//  Created by Work on 14/8/24.
//

import Foundation

struct PersonViewDataTranslator {
    
    static func createPersonViewDataArray(from personArray: [Person]) -> [PersonViewData] {
        personArray.map {
            .init(id: $0.id, name: $0.name)
        }
    }
}
