//
//  MainView.swift
//  DishJourney
//
//  Created by Melissa Zellhuber on 12/05/24.
//

import SwiftUI

struct MainView: View {
  @State private var selectedTab: Tab = .home

  enum Tab: String, CaseIterable {
    case mealPlanner = "calendar"
    case home = "house.fill"
    case favorites = "heart.fill"
  }

  var body: some View {
    VStack(spacing: 0) {
      // Content views
      ZStack {
        MealPlannerView()
          .hiddenUnless(.mealPlanner == selectedTab)
        RecipesView()
          .hiddenUnless(.home == selectedTab)
        FavoritesView()
          .hiddenUnless(.favorites == selectedTab)
      }

      HStack {
        ForEach(Tab.allCases, id: \.self) { tab in
          tabButton(for: tab)
            .accessibilityIdentifier("\(tab.rawValue)TabButton")
        }
      }
      .padding(.top, 8)
      .background(
        LinearGradient(
          gradient: Gradient(
            colors: [
              Color(UIColor.secondarySystemBackground),
              Color(UIColor.systemBackground)
            ]
          ),
          startPoint: .top,
          endPoint: .bottom
        )
      )
      .cornerRadius(15)
      .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: -4)
      .overlay(
        RoundedRectangle(cornerRadius: 15)
          .stroke(Color.gray.opacity(0.2), lineWidth: 0.5)
      )
      .padding(.horizontal, 8)
    }
  }

  private func tabButton(for tab: Tab) -> some View {
    Button(
      action: {
        withAnimation(.easeInOut) {
          selectedTab = tab
        }
      },
      label: {
        VStack {
          ZStack {
            if selectedTab == tab {
              Circle()
                .fill(
                  LinearGradient(
                    gradient: Gradient(colors: [Color.blue, Color.purple]),
                    startPoint: .leading,
                    endPoint: .trailing
                  )
                )
                .frame(width: 40, height: 40)
                .shadow(radius: 3)
                .overlay(
                  Image(systemName: tab.rawValue)
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                )
            } else {
              Image(systemName: tab.rawValue)
                .font(.system(size: 20))
                .foregroundColor(.gray)
            }
          }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
      }
    )
  }
}

extension View {
  @ViewBuilder
  func hiddenUnless(_ condition: Bool) -> some View {
    if condition {
      self
    } else {
      hidden()
    }
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
