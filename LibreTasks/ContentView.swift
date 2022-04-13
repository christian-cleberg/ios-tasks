//
//  ContentView.swift
//  LibreTasks
//
//  Created by kaizoku on 4/12/22.
//

import SwiftUI

// Combine is used to handle asynchronous events
import Combine

struct ContentView: View {
    // @ObservedObject is a property wrapper that gives the views (User Interface) a way to watch the state of an object. For example, a datastore.
    // Here we create a taskStore observedObject that references to TaskDataStore (We will be defining this later on).
    @ObservedObject var taskStore = TaskDataStore()

    // The state property wrapper is used to move the variable storage outside of the current struct into shared storage.
    // We create a variable newTask to maintain the current task that is entered on the screen.
    @State var newTask : String = ""
    
    // This view defines a taskbar, which will be used to enter tasks and add them.
    var addTaskBar : some View {
        // HStack arranges the items horizontally.
        HStack {
            // the self.$newTask binds the content of the textbox to the newTask state variable.
            TextField("Add Task: ", text: self.$newTask)
            // Whenever the button is clicked, it fires the addNewTask function.
            Button(action: self.addNewTask, label: {
                Text("Add New")
            })
        }
    }
    
    func addNewTask() {
        // This accesses the dataStore and appends a new task to it.
        taskStore.tasks.append(Task(
            // We maintain an ID and taskItem, as defined in the DataStore.
            id: String(taskStore.tasks.count + 1),
            taskItem: newTask
        ))
        // This line sets newTask to an empty string
        // When we add the task to the list, it erases the textbox
        self.newTask = ""
    }

    // Body of the ContentView
    var body: some View {
        // A View that can be used in a scenario where a user would want to move across views.
        NavigationView {
            // A VStack arranges the elements vertically.
            VStack {
                // Here, we call the function, addTaskBar.
                addTaskBar.padding()
                // A List is used to present data in a single column.
                List {
                    // ForEach is used to loop over a collection of items to create views.
                    ForEach(self.taskStore.tasks) { task in
                        // The Task string is displayed as text.
                        Text(task.taskItem)
                    }.onDelete(perform: self.deleteTask) // We also define a delete event that can performs the deleteTask function.
                }.navigationBarTitle("Tasks").navigationBarItems(trailing: EditButton())
                // We name the navbar as Tasks and add an edit button (this is provided by the SwiftUI library)
            }
        }
    }
    
    // at offsets deletes the task at the offset where you clicked the delete button
    func deleteTask(at offsets: IndexSet) {
        taskStore.tasks.remove(atOffsets: offsets)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
