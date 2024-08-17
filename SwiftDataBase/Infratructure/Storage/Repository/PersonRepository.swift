//
//  PersonRepository.swift
//  SwiftDataBase
//
//  Created by Work on 15/6/24.
//

import Foundation
import SwiftData

struct PersonRepository: SwiftDataBaseRepositoryType {
    
    typealias T = PersonStorage
    
    var swiftDataManager: SwiftDataManager<PersonStorage> = .init()
}

extension PersonRepository: PersonRepositoryType {

    func getPersonList() -> Observable<[Person]> {
        let request = PersonRequest()
        return getList(input: request).flatMap {
            $0.publisher
        }.map {
            Person(id: $0.id, name: $0.name)
        }
        .collect()
        .eraseToAnyPublisher()
    }
    
    func addPerson(_ person: Person) {
        let person = T(name: person.name)
        swiftDataManager.insert(object: person)
    }
    
    func delete(personID: String) {
        let predicate = #Predicate<T> {
            $0.id == personID
        }
        swiftDataManager.delete(model: T.self, where: predicate)
    }
}
