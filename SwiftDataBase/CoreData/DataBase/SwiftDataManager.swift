//
//  SwiftDataManager.swift
//  SwiftDataBase
//
//  Created by Work on 15/6/24.
//

import Combine
import SwiftData

struct SwiftDataManager<T: PersistentModel> {
    let container: ModelContainer
    private let context: ModelContext
    
    init() {
        do {
            self.container = try ModelContainer(for: T.self)
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
