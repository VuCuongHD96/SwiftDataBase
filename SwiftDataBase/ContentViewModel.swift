//
//  ContentViewModel.swift
//  SwiftDataBase
//
//  Created by Work on 3/8/24.
//

import Combine

struct ContentViewModel: ViewModel {
    
    let repository: PersonRepositoryType = PersonRepository()
}

extension ContentViewModel {
    
    class Input: ObservableObject {
        var addAction = PassthroughSubject<Void, Never>()
        var loadTrigger = PassthroughSubject<Void, Never>()
        var deleteAction = PassthroughSubject<String, Never>()
        @Published var personName = ""
    }
    
    class Output: ObservableObject {
        @Published var personList: [PersonViewData] = []
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        let addPersonPublisher = input.addAction
            .handleEvents(receiveOutput: {
                let person = Person(name: input.personName)
                repository.addPerson(person)
            })
            .mapToVoid()

        Publishers.Merge(
            input.loadTrigger,
            addPersonPublisher
        )
        .flatMap {
            repository.getPersonList()
                .asDriver()
        }
        .map {
            PersonViewDataTranslator.createPersonViewDataArray(from: $0)
        }
        .assign(to: \.personList, on: output)
        .store(in: cancelBag)
        
        input.deleteAction
            .sink {
                repository.delete(personID: $0)
            }
            .store(in: cancelBag)
        
        return output
    }
}

extension Publisher {
    
    func mapToVoid() -> AnyPublisher<Void, Failure> {
        return map { _ in
            ()
        }
        .eraseToAnyPublisher()
    }
}
