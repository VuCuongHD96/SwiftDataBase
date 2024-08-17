//
//  CoreDataBaseRequest.swift
//  MovieSwiftUI
//
//  Created by Work on 26/09/2023.
//

import Foundation
import SwiftData

protocol SwiftDataBaseRequestType {
    associatedtype T: PersistentModel
    var request: FetchDescriptor<T> { get }
}
