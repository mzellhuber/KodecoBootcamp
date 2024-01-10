//
//  Task.swift
//  TaskApp
//
//  Created by Melissa Zellhuber on 10/01/24.
//

import Foundation

struct Task: Identifiable {
    let id: UUID
    var title: String
    var isCompleted: Bool
    var notes: String
}
