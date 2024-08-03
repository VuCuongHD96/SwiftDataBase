//
//  ContentView.swift
//  SwiftDataBase
//
//  Created by Work on 15/6/24.
//

import SwiftUI

struct ContentView: View {

    let input: ContentViewModel.Input
    @ObservedObject var output: ContentViewModel.Output
    let cancelBag = CancelBag()
    
    init(viewModel: ContentViewModel) {
        let input = ContentViewModel.Input()
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
    }
    
    var body: some View {
        VStack {
            Button("Add Person") {
                input.addAction.send()
            }
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            List {
                ForEach(output.personList) {
                    Text($0.name)
                }
                .onDelete(perform: { indexSet in
                    indexSet.forEach {
                        let person = output.personList[$0]
                        input.deleteAction.send(person)
                    }
                })
            }
        }
        .padding()
        .onAppear {
            input.loadTrigger.send()
        }
    }
}

#Preview {
    ContentView(viewModel: ContentViewModel())
}
