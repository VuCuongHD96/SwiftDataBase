//
//  SwiftDataBaseRepositoryType.swift
//  MovieSwiftUI
//
//  Created by Work on 26/09/2023.
//

import Combine
import SwiftData

protocol SwiftDataBaseRepositoryType {
    
    associatedtype T = any PersistentModel
    var swiftDataManager: SwiftDataManager { get set }
}
