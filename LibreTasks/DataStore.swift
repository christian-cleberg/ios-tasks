//
//  DataStore.swift
//  LibreTasks
//
//  Created by christian-cleberg on 4/12/22.
//

import Foundation
import SwiftUI
import Combine

struct Task : Identifiable {
    var id = String()
    var taskItem = String()
}

class TaskDataStore: ObservableObject {
    @Published var tasks = [Task]()
}
