//
//  NewTaskView.swift
//  TaskApp
//
//  Created by Melissa Zellhuber on 10/01/24.
//

import SwiftUI

struct NewTaskView: View {
    @ObservedObject var store: TaskStore
    @State private var title: String = ""
    @State private var notes: String = ""
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Title")) {
                    TextField("Title", text: $title)
                }

                Section(header: Text("Notes")) {
                    TextField("Notes", text: $notes)
                }
            }
            .navigationTitle("Adding New Task")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                },
                trailing: Button("Add") {
                    let newTask = Task(id: UUID(), title: title, isCompleted: false, notes: notes)
                    store.addTask(newTask)
                    dismiss()
                }.disabled(title.isEmpty)
            )
        }
    }
}


struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskView(store: TaskStore())
    }
}
