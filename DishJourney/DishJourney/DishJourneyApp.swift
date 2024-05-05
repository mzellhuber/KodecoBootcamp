//
//  DishJourneyApp.swift
//  DishJourney
//
//  Created by Melissa Zellhuber on 02/05/24.
//

import SwiftUI

@main
struct DishJourneyApp: App {
    @State private var isShowingSplash = true

    var body: some Scene {
        WindowGroup {
            if isShowingSplash {
                SplashScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            isShowingSplash = false
                        }
                    }
            } else {
                RecipesView()
            }
        }
    }
}
