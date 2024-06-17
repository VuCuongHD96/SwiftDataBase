//
//  ContentView.swift
//  SwiftDataBase
//
//  Created by Work on 15/6/24.
//

import SwiftUI

struct ContentView: View {
    
    let repository: any PersonRepositoryType = PersonRepository()
    @State private var person: [Person] = []
    
    var body: some View {
        VStack {
            Button("Add Person") {
                repository.addPerson()
                person = repository.getPersonList()
                repository.swiftDataManager.save()
            }
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            List {
                ForEach(person) {
                    Text($0.name)
                }
                .onDelete(perform: { indexSet in
                    indexSet.forEach {
                        let person = person[$0]
                        repository.delete(object: person)
                        repository.swiftDataManager.save()
                    }
                })
            }
        }
        .padding()
        .onAppear {
            person = repository.getPersonList()
            repository.swiftDataManager.save()
        }
    }
}

#Preview {
    ContentView()
}
