//
//  MainTabView.swift
//  TaskApp
//
//  Created by Melissa Zellhuber on 29/01/24.
//

import SwiftUI

struct MainTabView: View {
    @StateObject var store = TaskStore()
    @State private var searchText = ""

    var body: some View {
        TabView {
            TaskListView(store: store, showCompletedTasks: false, searchText: $searchText)
                .tabItem {
                    Label("Tasks", systemImage: "list.bullet.circle")
                }

            TaskListView(store: store, showCompletedTasks: true, searchText: $searchText)
                .tabItem {
                    Label("Completed", systemImage: "checkmark.circle")
                }
        }
        .searchable(text: $searchText, prompt: "Search Tasks")
    }
}


#Preview {
    MainTabView()
}
