//
//  TaskRow.swift
//  TaskApp
//
//  Created by Melissa Zellhuber on 10/01/24.
//

import SwiftUI

struct TaskRow: View {
    @Binding var task: Task

    var body: some View {
        HStack {
            Text(task.title)
                .bold()
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity, alignment: .leading)

            Image(systemName: task.isCompleted ? "checkmark.square.fill" : "square")
                .foregroundColor(task.isCompleted ? .green : .red)
                .onTapGesture {
                    withAnimation {
                        task.isCompleted.toggle()
                    }
                }
                .scaleEffect(task.isCompleted ? 1.2 : 1.0)
        }
        .padding()
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRow(task: .constant(Task(id: UUID(), title: "Test", isCompleted: false, notes: "")))
    }
}
