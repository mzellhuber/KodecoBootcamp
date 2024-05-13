//
//  RecipeDetailView.swift
//  DishJourney
//
//  Created by Melissa Zellhuber on 11/05/24.
//

import SwiftUI

struct RecipeDetailView: View {
    var recipe: Recipe
    @ObservedObject var favoritesManager = FavoritesManager.shared

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: recipe.image)) {
                    $0.resizable()
                } placeholder: {
                    Color.gray.opacity(0.3)
                        .overlay(Text("Loading..."))
                }
                .aspectRatio(contentMode: .fill)
                .frame(height: 250)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal)
                .shadow(radius: 5)
                
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text(recipe.label)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.primary)
                        
                        Spacer()
                        
                        Button(action: {
                            favoritesManager.toggleFavorite(recipe: recipe)
                        }) {
                            Image(systemName: favoritesManager.isFavorite(recipe: recipe) ? "heart.fill" : "heart")
                                .foregroundColor(favoritesManager.isFavorite(recipe: recipe) ? .red : .gray)
                                .animation(.easeInOut, value: favoritesManager.isFavorite(recipe: recipe))
                        }
                    }
                    
                    HStack {
                        DetailChipView(label: "Cuisine", content: recipe.cuisineType.map { $0.rawValue.capitalized }.joined(separator: ", "))
                        DetailChipView(label: "Dish Type", content: recipe.dishType?.map { $0.rawValue.capitalized }.joined(separator: ", ") ?? "N/A")
                    }
                    
                    DetailChipView(label: "Cook Time", content: "\(recipe.totalTime) minutes")
                    
                    CollapsibleSectionView(title: "Ingredients", content: recipe.ingredientLines.map { "• \($0)" }.joined(separator: "\n"))
                    
                    CollapsibleSectionView(
                        title: "Nutritional Information",
                        content: recipe.digest.map {
                            let formattedTotal = String(format: "%.2f", $0.total)
                            return "\($0.label): \(formattedTotal) \($0.unit.rawValue)"
                        }.joined(separator: "\n")
                    )
                    
                    Button("See Full Recipe", action: {
                        if let url = URL(string: recipe.url), UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url)
                        }
                    })
                    .buttonStyle(GradientBackgroundButtonStyle())
                    .padding(.top, 20)
                }
                .padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 5)
                .padding(.horizontal)
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("Recipe Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipe: Recipe(
            uri: "http://example.com",
            label: "Chocolate Cake",
            image: "https://www.example.com/image.jpg",
            source: "Source",
            url: "https://www.example.com",
            shareAs: "https://www.example.com",
            yield: 8,
            dietLabels: [.balanced],
            healthLabels: [.eggFree, .peanutFree],
            cautions: ["Nuts"],
            ingredientLines: ["2 cups flour", "1 cup sugar", "2 eggs"],
            ingredients: [Ingredient(text: "1 cup sugar", quantity: 1, measure: "cup", food: "sugar", weight: 200, foodCategory: "sugars", foodID: "12345", image: nil)],
            calories: 2500,
            totalWeight: 1000,
            totalTime: 45,
            cuisineType: [.american],
            mealType: [.snack],
            dishType: [.desserts],
            totalNutrients: ["FAT": Total(label: "Fat", quantity: 100, unit: .g)],
            totalDaily: ["FAT": Total(label: "Fat", quantity: 50, unit: .g)],
            digest: [Digest(label: "Protein", tag: "PROCNT", schemaOrgTag: .proteinContent, total: 30, hasRDI: true, daily: 60, unit: .g, sub: nil)],
            tags: ["tag1", "tag2"]
        ))
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
