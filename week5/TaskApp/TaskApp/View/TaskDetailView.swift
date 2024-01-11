//
//  TaskDetailView.swift
//  TaskApp
//
//  Created by Melissa Zellhuber on 10/01/24.
//

import SwiftUI

struct TaskDetailView: View {
    @Binding var task: Task

    var body: some View {
        Form {
            Section(header: Text("Task Title")) {
                TextField("Title", text: $task.title)
            }

            Section(header: Text("Notes")) {
                TextField("Notes", text: $task.notes)
            }

            Section {
                Toggle(isOn: $task.isCompleted) {
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
        let sampleTask = Task(id: UUID(), title: "Sample Task", isCompleted: false, notes: "Sample notes")
        TaskDetailView(task: .constant(sampleTask))
    }
}
