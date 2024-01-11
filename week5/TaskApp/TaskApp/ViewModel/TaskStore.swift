//
//  TaskStore.swift
//  TaskApp
//
//  Created by Melissa Zellhuber on 10/01/24.
//

import Foundation

class TaskStore: ObservableObject {
    @Published var tasks: [Task] = []
    
    init() {
        self.tasks = [
            Task(id: UUID(), title: "Grocery Shopping", isCompleted: false, notes: "Remember to buy eggs, milk, and bread."),
            Task(id: UUID(), title: "iOS Project", isCompleted: false, notes: "Complete the UI design for the new app feature."),
            Task(id: UUID(), title: "Jogging", isCompleted: false, notes: "Go for a 30-minute run in the park."),
            Task(id: UUID(), title: "Read Book", isCompleted: false, notes: "Read next chapter of 'The SwiftUI Handbook'."),
            Task(id: UUID(), title: "Gardening", isCompleted: false, notes: "Water the garden and trim the hedges.")
        ]
    }
    
    func addTask(_ task: Task) {
        tasks.append(task)
    }
}
