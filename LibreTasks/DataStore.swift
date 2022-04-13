//
//  DataStore.swift
//  LibreTasks
//
//  Created by kaizoku on 4/12/22.
//

import Foundation
import SwiftUI
import Combine

// Here we define an ID and a TaskItem for every Task.
struct Task : Identifiable {
    var id = String()
    var taskItem = String()
}

// We define the DataStore as an array of Tasks.
class TaskDataStore: ObservableObject {
    // @Published is a property wrapper that announces when changes occur to the DataStore.
    @Published var tasks = [Task]()
}
