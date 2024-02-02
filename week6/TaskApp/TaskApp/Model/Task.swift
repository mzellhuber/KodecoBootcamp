//
//  Task.swift
//  TaskApp
//
//  Created by Melissa Zellhuber on 10/01/24.
//

import Foundation

struct Task: Identifiable, Hashable {
    let id: UUID
    var title: String
    var isCompleted: Bool
    var notes: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
    }
}
