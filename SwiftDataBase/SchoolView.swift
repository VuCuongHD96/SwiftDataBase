//
//  SchoolView.swift
//  SwiftDataBase
//
//  Created by Work on 17/8/24.
//

import SwiftUI
import Combine

struct SchoolView: View {
    
    var input: SchoolViewModel.Input
    
    let viewModel = SchoolViewModel()
    
    init() {
        let input = SchoolViewModel.Input()
        self.input = input
    }
    
    var body: some View {
        Text("abc")
//            .onAppear {
//                input.loadTrigger.send()
//            }
    }
}

#Preview {
    SchoolView()
}

struct SchoolViewModel {
    
    let schoolRepo = SchoolRepository()
}

extension SchoolViewModel: ViewModel {
    
    struct Input {
        var loadTrigger = PassthroughSubject<Void, Never>()
    }
     
    struct Output {
        
    }

    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        input.loadTrigger
            .flatMap {
                schoolRepo.getSchoolList()
                    .asDriver()
            }
            .sink {
                print("--- debug --- school = ", $0)
            }
            .store(in: cancelBag)
        
        return output
    }
}
