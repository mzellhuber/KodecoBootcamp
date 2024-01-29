//
//  TaskListView.swift
//  TaskApp
//
//  Created by Melissa Zellhuber on 10/01/24.
//

import SwiftUI

struct TaskListView: View {
    @StateObject var store = TaskStore()
    @State private var showingNewTaskSheet = false
    var showCompletedTasks: Bool

    var filteredTasks: [Task] {
        store.tasks.filter { $0.isCompleted == showCompletedTasks }
    }

    var body: some View {
        NavigationStack {
            List(filteredTasks) { task in
                NavigationLink(destination: TaskDetailView(task: Binding(get: { task }, set: { newTask in
                    if let index = store.tasks.firstIndex(where: { $0.id == newTask.id }) {
                        store.tasks[index] = newTask
                    }
                }))) {
                    TaskRow(task: task)
                }
            }
            .navigationTitle(showCompletedTasks ? "Completed" : "My Tasks")
            .listStyle(PlainListStyle())

            if !showCompletedTasks {
                HStack {
                    Button(action: {
                        showingNewTaskSheet = true
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("New Task")
                        }
                        .foregroundColor(.blue)
                        .padding()
                    }
                    .sheet(isPresented: $showingNewTaskSheet) {
                        NewTaskView(store: store)
                    }
                    Spacer()
                }
            }
        }
        .background(Color.white)
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            let mockStore = TaskStore()

            TaskListView(store: mockStore, showCompletedTasks: false)
                .previewDisplayName("Incomplete Tasks")

            TaskListView(store: mockStore, showCompletedTasks: true)
                .previewDisplayName("Completed Tasks")
        }
    }
}
