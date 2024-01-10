//
//  TaskStore.swift
//  TaskApp
//
//  Created by Melissa Zellhuber on 10/01/24.
//

import Foundation

class TaskStore: ObservableObject {
    @Published var tasks: [Task] = []

    func addTask(_ task: Task) {
        tasks.append(task)
    }
}
