//
//  MainTabView.swift
//  TaskApp
//
//  Created by Melissa Zellhuber on 29/01/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            TaskListView(showCompletedTasks: false)
                .tabItem {
                    Label("Tasks", systemImage: "list.bullet.circle")
                }

            TaskListView(showCompletedTasks: true)
                .tabItem {
                    Label("Completed", systemImage: "checkmark.circle")
                }
        }
    }
}

#Preview {
    MainTabView()
}
