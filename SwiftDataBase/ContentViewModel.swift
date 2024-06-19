//
//  ContentViewModel.swift
//  SwiftDataBase
//
//  Created by Work on 3/8/24.
//

import Combine

struct ContentViewModel: ViewModel {
    
    let repository = PersonRepository()
}

extension ContentViewModel {
    
    struct Input {
        var addAction = PassthroughSubject<Void, Never>()
        var loadTrigger = PassthroughSubject<Void, Never>()
        var deleteAction = PassthroughSubject<Person, Never>()
    }
    
    class Output: ObservableObject {
        @Published var personList: [Person] = []
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        let addPersonPublisher = input.addAction
            .map {
                repository.addPerson()
            }

        Publishers.Merge(
            input.loadTrigger,
            addPersonPublisher
        )
        .flatMap {
            repository.getPersonList()
                .asDriver()
        }
        .assign(to: \.personList, on: output)
        .store(in: cancelBag)
        
        input.deleteAction
            .sink {
                repository.delete(object: $0)
            }
            .store(in: cancelBag)
        
        return output
    }
}
