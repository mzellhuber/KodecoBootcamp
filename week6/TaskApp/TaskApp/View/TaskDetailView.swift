//
//  TaskDetailView.swift
//  TaskApp
//
//  Created by Melissa Zellhuber on 10/01/24.
//

import SwiftUI

struct TaskDetailView: View {
    @ObservedObject var store: TaskStore
    var taskIndex: Int

    var task: Task {
        store.tasks[taskIndex]
    }

    var body: some View {
        Form {
            Section(header: Text("Task Title")) {
                TextField("Title", text: Binding(
                    get: { self.task.title },
                    set: { self.store.tasks[taskIndex].title = $0 }
                ))
            }
            Section(header: Text("Notes")) {
                TextField("Notes", text: Binding(
                    get: { self.task.notes },
                    set: { self.store.tasks[taskIndex].notes = $0 }
                ))
            }
            Section {
                Toggle(isOn: Binding(
                    get: { self.task.isCompleted },
                    set: { self.store.tasks[taskIndex].isCompleted = $0 }
                )) {
                    Text("Completed")
                }
            }
        }
        .navigationTitle("Task Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let mockStore = TaskStore()

        TaskDetailView(store: mockStore, taskIndex: 0)
    }
}
