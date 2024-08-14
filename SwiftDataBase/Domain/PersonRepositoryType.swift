//
//  PersonRepositoryType.swift
//  SwiftDataBase
//
//  Created by Work on 14/8/24.
//

import Foundation

protocol PersonRepositoryType {

    func getPersonList() -> Observable<[Person]>
    func addPerson(_ person: Person)
    func delete(personID: String)
}
