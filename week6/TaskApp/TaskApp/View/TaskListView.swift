//
//  TaskListView.swift
//  TaskApp
//
//  Created by Melissa Zellhuber on 10/01/24.
//

import SwiftUI

struct TaskListView: View {
    @StateObject var store: TaskStore
    let showCompletedTasks: Bool
    @Binding var searchText: String
    @State private var isAddTaskSheetPresented = false

    var filteredTaskSet: Set<Task> {
        Set(store.tasks.filter { task in
            (task.isCompleted == showCompletedTasks) &&
            (searchText.isEmpty || task.title.localizedCaseInsensitiveContains(searchText) ||
             task.notes.localizedCaseInsensitiveContains(searchText))
        })
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(store.tasks.filter { filteredTaskSet.contains($0) }, id: \.self) { task in
                    if let taskIndex = store.tasks.firstIndex(of: task) {
                        NavigationLink(
                            destination: TaskDetailView(store: store, taskIndex: taskIndex),
                            label: {
                                TaskRow(task: $store.tasks[taskIndex])
                            }
                        )
                    }
                }
            }
            .navigationTitle(showCompletedTasks ? "Completed" : "My Tasks")
            .listStyle(PlainListStyle())
            .navigationBarItems(
                trailing: Button(action: {
                    isAddTaskSheetPresented = true
                }) {
                    Image(systemName: "plus.circle.fill")
                }
            )
            .sheet(isPresented: $isAddTaskSheetPresented) {
                NewTaskView(store: store)
            }
        }
        .searchable(text: $searchText)
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            let mockStore = TaskStore()

            TaskListView(store: mockStore, showCompletedTasks: false, searchText: .constant(""))
                .previewDisplayName("Incomplete Tasks")

            TaskListView(store: mockStore, showCompletedTasks: true, searchText: .constant(""))
                .previewDisplayName("Completed Tasks")
        }
    }
}
