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

    var body: some View {
        NavigationStack {
            List(store.tasks.filter { !$0.isCompleted }) { task in
                NavigationLink(destination: TaskDetailView(task: Binding(get: { task }, set: { newTask in
                    if let index = store.tasks.firstIndex(where: { $0.id == newTask.id }) {
                        store.tasks[index] = newTask
                    }
                }))) {
                    TaskRow(task: task)
                }
            }
            .navigationTitle("My Tasks")
            .listStyle(PlainListStyle())

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
        .background(Color.white)
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        let mockStore = TaskStore()
        mockStore.tasks = [
            Task(id: UUID(), title: "Sample Task 1", isCompleted: false, notes: "This is a note"),
            Task(id: UUID(), title: "Sample Task 2", isCompleted: true, notes: "Another note")
        ]

        return TaskListView(store: mockStore)
    }
}
