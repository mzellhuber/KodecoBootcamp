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
            Text(task.title)
                .bold()
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity, alignment: .leading)

            if task.isCompleted {
                Image(systemName: "checkmark.square.fill")
                    .foregroundColor(.green)
            } else {
                Image(systemName: "square")
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
}

#Preview {
    TaskRow(task: Task(id: UUID(), title: "Test", isCompleted: false, notes: ""))
}
