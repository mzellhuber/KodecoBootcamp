//
//  MealPlannerView.swift
//  DishJourney
//
//  Created by Melissa Zellhuber on 12/05/24.
//

import SwiftUI

struct MealPlannerView: View {
    @StateObject private var viewModel = MealPlannerViewModel()

    var body: some View {
        NavigationView {
            List {
                configurationSection
                actionSection
                if let mealPlan = viewModel.mealPlan, !mealPlan.isEmpty {
                    ForEach(0..<viewModel.numberOfDays, id: \.self) { day in
                        DisclosureGroup("Day \(day + 1)") {
                            daySection(day: day, mealPlan: mealPlan)
                        }
                        .accessibilityIdentifier("Day\(day + 1)DisclosureGroup")
                    }
                } else {
                    if viewModel.noResults {
                        Text("No meal plan available. Please try another combination.")
                            .foregroundColor(.red)
                            .fontWeight(.bold)
                            .padding()
                            .transition(.opacity.animation(.spring()))
                            .accessibilityIdentifier("NoMealPlanErrorText")
                    } else {
                        Text("No meal plan available. Please create one.")
                            .transition(.opacity.animation(.spring()))
                            .accessibilityIdentifier("NoMealPlanText")
                    }
                }
            }
            .navigationTitle("Meal Planner")
            .listStyle(GroupedListStyle())
        }
    }

    var configurationSection: some View {
        Section(header: Text("Meal Plan Configuration")) {
            daysPicker
            dietTypePicker
            healthLabelSelector
            calorieRangeFields
            mealTypeSelector
        }
    }

    var mealTypeSelector: some View {
        MultipleSelectionSection(title: "Meal Types",
                                 options: MealType.allCases,
                                 selectedOptions: $viewModel.selectedMealTypes)
    }

    @ViewBuilder
    private func daySection(day: Int, mealPlan: [Recipe]) -> some View {
        ForEach(viewModel.selectedMealTypes, id: \.self) { mealType in
            mealTypeSection(mealType: mealType, day: day, mealPlan: mealPlan)
        }
    }

    private func mealTypeSection(mealType: MealType, day: Int, mealPlan: [Recipe]) -> some View {
        let dailyRecipes = mealPlan.filter { $0.mealType.contains(mealType) && $0.day == day }
        return Section(header: Text(mealType.rawValue.capitalized)) {
            ForEach(dailyRecipes, id: \.id) { recipe in
                NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                    RecipeRow(recipe: recipe)
                        .accessibilityIdentifier("\(mealType.rawValue.capitalized)RecipeRow")
                }
            }
        }
    }

    var daysPicker: some View {
        Picker("Number of Days", selection: $viewModel.numberOfDays) {
            ForEach(1..<8, id: \.self) { day in
                Text("\(day)").tag(day)
            }
        }
    }

    var dietTypePicker: some View {
        Picker("Diet Type", selection: $viewModel.selectedDietLabel) {
            ForEach(DietLabel.allCases, id: \.self) { dietLabel in
                Text(dietLabel.rawValue.capitalized).tag(dietLabel)
            }
        }
        .pickerStyle(MenuPickerStyle())
    }

    var healthLabelSelector: some View {
        MultipleSelectionSection(title: "Health Labels",
                                 options: HealthLabel.allCases,
                                 selectedOptions: $viewModel.selectedHealthLabels)
    }

    var calorieRangeFields: some View {
        HStack {
            TextField("Calorie Range Min", text: $viewModel.calorieMinString)
                .keyboardType(.numberPad)
            TextField("Calorie Range Max", text: $viewModel.calorieMaxString)
                .keyboardType(.numberPad)
        }
    }

    var actionSection: some View {
        Section {
            Button("Create Meal Plan") {
                viewModel.fetchMealPlan()
            }
            .accessibilityIdentifier("CreateMealPlanButton")
        }
    }
}

struct MultipleSelectionSection<Options: Hashable & Codable & CaseIterable>: View where Options: RawRepresentable, Options.RawValue == String {
    let title: String
    let options: [Options]
    @Binding var selectedOptions: [Options]

    var body: some View {
        VStack(alignment: .leading) {
            Text(title).font(.headline)
            ForEach(options, id: \.self) { option in
                Toggle(isOn: Binding(
                    get: { selectedOptions.contains(option) },
                    set: { isSelected in
                        if isSelected {
                            if !selectedOptions.contains(option) {
                                selectedOptions.append(option)
                            }
                        } else {
                            selectedOptions.removeAll { $0 == option }
                        }
                    }
                )) {
                    Text(option.rawValue.capitalized)
                }
            }
        }
    }
}

#Preview {
    MealPlannerView()
}
