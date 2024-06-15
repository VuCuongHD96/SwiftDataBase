//
//  SwiftDataManager.swift
//  SwiftDataBase
//
//  Created by Work on 15/6/24.
//

import Foundation
import SwiftData

struct SwiftDataManager {
    
    typealias T = PersistentModel
    private let context: ModelContext
    
    init(modelType: any T.Type) {
        let container = (try? ModelContainer(for: modelType))!
        context = ModelContext(container)
    }
    
    func fetch<R: SwiftDataBaseRequestType>(input: R) -> [R.T] {
        return try! context.fetch(input.request)
    }
    
    func insert(object: any T) {
        context.insert(object)
    }
    
    func delete(object: any T) {
        context.delete(object)
    }

    func save() {
        try? context.save()
    }
}
