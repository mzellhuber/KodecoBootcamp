//
//  TaskRow.swift
//  TaskApp
//
//  Created by Melissa Zellhuber on 10/01/24.
//

import SwiftUI

struct TaskRow: View {
    @Binding var task: Task
    @State private var rotation: Double = 0
    @State private var scale: CGFloat = 1.0

    var body: some View {
        HStack {
            Text(task.title)
                .bold()
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity, alignment: .leading)

            Image(systemName: task.isCompleted ? "checkmark.square.fill" : "square")
                .foregroundColor(task.isCompleted ? .green : .red)
                .rotationEffect(.degrees(rotation))
                .scaleEffect(scale)
                .onTapGesture {
                    withAnimation {
                        task.isCompleted.toggle()
                        if task.isCompleted {
                            rotation = 0
                            scale = 1.5
                        } else {
                            rotation = -90
                            scale = 1.0
                        }
                    }
                }
        }
        .padding()
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRow(task: .constant(Task(id: UUID(), title: "Test", isCompleted: false, notes: "")))
    }
}
