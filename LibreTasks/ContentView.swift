//
//  ContentView.swift
//  LibreTasks
//
//  Created by christian-cleberg on 4/12/22.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var taskStore = TaskDataStore()
    @State var newTask : String = ""
    @State private var query = ""
    
    var filteredTasks: [Task] {
        if query.isEmpty {
            return self.taskStore.tasks
        } else {
            return taskStore.tasks.filter {
                $0.taskItem.localizedCaseInsensitiveContains(query)
            }
        }
    }
    
    var addTaskBar : some View {
        HStack {
            TextField("Add Task: ", text: self.$newTask)
            Button(action: self.addNewTask, label: {
                Text("Add New")
            })
        }
    }
    
    func addNewTask() {
        taskStore.tasks.append(Task(
            id: String(taskStore.tasks.count + 1),
            taskItem: newTask
        ))
        self.newTask = ""
    }

    var body: some View {
        NavigationView {
            VStack {
                addTaskBar.padding()
                List {
                    ForEach(filteredTasks) { task in
                        Text(task.taskItem)
                    }
                    .onDelete(perform: self.deleteTask)
                }
                .navigationBarTitle("Tasks")
                .navigationBarItems(trailing: EditButton())
            }
        }
        .searchable(text: $query, prompt: "Search tasks")
    }
    
    func deleteTask(at offsets: IndexSet) {
        taskStore.tasks.remove(atOffsets: offsets)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
