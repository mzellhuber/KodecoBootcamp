//
//  TaskListView.swift
//  TaskApp
//
//  Created by Melissa Zellhuber on 10/01/24.
//

import SwiftUI

struct TaskListView: View {
    @StateObject var store = TaskStore()

    var body: some View {
        NavigationStack {
            ForEach(store.tasks) { task in
                TaskRow(task: task)
            }
        }
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
