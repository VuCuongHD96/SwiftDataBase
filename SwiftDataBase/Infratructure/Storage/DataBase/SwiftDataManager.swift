//
//  SwiftDataManager.swift
//  SwiftDataBase
//
//  Created by Work on 15/6/24.
//

import Combine
import SwiftData
import Foundation

struct SwiftDataManager {
   
    let container: ModelContainer
    private let context: ModelContext
    typealias T = any PersistentModel
    static let shared = SwiftDataManager()
    
    init() {
        do {
            self.container = try ModelContainerMaker.make()
        } catch(let error) {
            fatalError("Unresolved error \(error), \(error.localizedDescription)")
        }
        context = ModelContext(container)
    }

    func fetch<R: SwiftDataBaseRequestType>(input: R) -> Observable<[R.T]> {
        Future<[R.T], Error> { promise in
            do {
                let itemArray = try context.fetch(input.request)
                promise(.success(itemArray))
            } catch(let error) {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func insert(object: T) {
        context.insert(object)
    }
    
    func delete(object: T) {
        context.delete(object)
    }
    
    func delete<T: PersistentModel>(model: T.Type, where predicate: Predicate<T>) {
        do {
            try context.delete(model: T.self, where: predicate)
        } catch {
            
        }
    }
    
    func save() -> Observable<Void> {
        Future<Void, Error> { promise in
            do {
                try context.save()
                promise(.success(Void()))
            } catch(let error) {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}
