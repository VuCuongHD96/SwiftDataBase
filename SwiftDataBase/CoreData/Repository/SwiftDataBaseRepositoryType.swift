//
//  SwiftDataBaseRepositoryType.swift
//  MovieSwiftUI
//
//  Created by Work on 26/09/2023.
//

import Combine
import SwiftData

protocol SwiftDataBaseRepositoryType {
    associatedtype T: PersistentModel
    var swiftDataManager: SwiftDataManager<T> { get set }
}

extension SwiftDataBaseRepositoryType {
    
    func getList<R: SwiftDataBaseRequestType>(input: R) -> Observable<[R.T]> {
        return swiftDataManager.fetch(input: input)
    }
    
    func insert(object: T) {
        swiftDataManager.insert(object: object)
    }
    
    func delete(object: T) {
        swiftDataManager.delete(object: object)
    }
}
