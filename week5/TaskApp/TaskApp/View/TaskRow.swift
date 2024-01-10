//
//  TaskRow.swift
//  TaskApp
//
//  Created by Melissa Zellhuber on 10/01/24.
//

import SwiftUI

struct TaskRow: View {
    var task: Task

    var body: some View {
        HStack {
            Image(systemName: task.isCompleted ? "checkmark.square.fill" : "square")
                .foregroundColor(task.isCompleted ? .green : .red)
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.headline)
                if !task.notes.isEmpty {
                    Text(task.notes)
                        .font(.subheadline)
                }
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}


#Preview {
    TaskRow(task: Task(id: UUID(), title: "Test", isCompleted: false, notes: ""))
}
