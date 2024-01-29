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

    var filteredTasks: [Task] {
        store.tasks.filter { task in
            (task.isCompleted == showCompletedTasks) &&
            (searchText.isEmpty || task.title.localizedCaseInsensitiveContains(searchText) ||
             (task.notes.localizedCaseInsensitiveContains(searchText)))
        }
    }

    var body: some View {
        NavigationStack {
            List(filteredTasks) { task in
                if let index = store.tasks.firstIndex(where: { $0.id == task.id }) {
                    NavigationLink(destination: TaskDetailView(store: store, taskIndex: index)) {
                        TaskRow(task: task)
                    }
                }
            }
            .navigationTitle(showCompletedTasks ? "Completed" : "My Tasks")
            .listStyle(PlainListStyle())
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
