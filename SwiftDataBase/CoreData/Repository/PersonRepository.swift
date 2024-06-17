//
//  PersonRepository.swift
//  SwiftDataBase
//
//  Created by Work on 15/6/24.
//

import Foundation
import SwiftData

protocol PersonRepositoryType: SwiftDataBaseRepositoryType where T == Person {
    
    func getPersonList() -> [T]
    func addPerson()
    func delete(object: T)
}

struct PersonRepository: PersonRepositoryType {
    
    var swiftDataManager: SwiftDataManager = SwiftDataManager(modelType: T.self)

    func getPersonList() -> [T] {
        let request = PersonRequest()
        return swiftDataManager.fetch(input: request)
    }
    
    func addPerson() {
        let person = Person(name: "ABC")
        swiftDataManager.insert(object: person)
    }
    
    func delete(object: T) {
        swiftDataManager.delete(object: object)
    }
}
