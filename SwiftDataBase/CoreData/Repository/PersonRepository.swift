//
//  PersonRepository.swift
//  SwiftDataBase
//
//  Created by Work on 15/6/24.
//

import Foundation
import SwiftData

struct PersonRepository: SwiftDataBaseRepositoryType {

    typealias T = Person

    var swiftDataManager: SwiftDataManager<Person> = .init()

    func getPersonList() -> Observable<[T]> {
        let request = PersonRequest()
        return getList(input: request)
    }
    
    func addPerson() {
        let person = T(name: "ABC")
        swiftDataManager.insert(object: person)
    }
}
