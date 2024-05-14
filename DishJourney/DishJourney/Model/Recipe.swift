//
//  Recipe.swift
//  DishJourney
//
//  Created by Melissa Zellhuber on 02/05/24.
//

import Foundation

// MARK: - EdamamResponse
struct EdamamResponse: Codable {
    let query: String
    let from, to: Int
    let more: Bool
    let count: Int
    let hits: [Hit]

    enum CodingKeys: String, CodingKey {
        case query = "q"
        case from, to, more, count, hits
    }
}

// MARK: - Hit
struct Hit: Codable {
    let recipe: Recipe
}

// MARK: - Recipe
struct Recipe: Codable, Identifiable {
    let id = UUID()
    let uri: String
    let label: String
    let image: String
    let source: String
    let url: String
    let shareAs: String
    let yield: Int
    let dietLabels: [DietLabel]
    let healthLabels: [HealthLabel]
    let cautions, ingredientLines: [String]
    let ingredients: [Ingredient]
    let calories, totalWeight: Double
    let totalTime: Int
    let cuisineType: [CuisineType]
    var mealType: [MealType]
    let dishType: [DishType]?
    let totalNutrients, totalDaily: [String: Total]
    let digest: [Digest]
    let tags: [String]?
    var day: Int = 0
    
    var isFavorite: Bool = false

    enum CodingKeys: String, CodingKey {
        case uri, label, image, source, url, shareAs, yield, dietLabels, healthLabels, 
             cautions, ingredientLines, ingredients, calories, totalWeight, totalTime,
             cuisineType, mealType, dishType, totalNutrients, totalDaily, digest, tags
    }
}

enum DietLabel: String, Codable, CaseIterable {
    case balanced = "Balanced"
    case highFiber = "High-Fiber"
    case highProtein = "High-Protein"
    case lowCarb = "Low-Carb"
    case lowFat = "Low-Fat"
    case lowSodium = "Low-Sodium"
}

enum HealthLabel: String, Codable, CaseIterable {
    case alcoholCocktail = "Alcohol-Cocktail"
    case alcoholFree = "Alcohol-Free"
    case celeryFree = "Celery-Free"
    case crustaceanFree = "Crustacean-Free"
    case dairyFree = "Dairy-Free"
    case dash = "DASH"
    case eggFree = "Egg-Free"
    case fishFree = "Fish-Free"
    case fodmapFree = "FODMAP-Free"
    case glutenFree = "Gluten-Free"
    case immunoSupportive = "Immuno-Supportive"
    case ketoFriendly = "Keto-Friendly"
    case kidneyFriendly = "Kidney-Friendly"
    case kosher = "Kosher"
    case lowFatAbs = "Low-Fat-Abs"
    case lowPotassium = "Low Potassium"
    case lowSugar = "Low-Sugar"
    case lupineFree = "Lupine-Free"
    case mediterranean = "Mediterranean"
    case molluskFree = "Mollusk-Free"
    case mustardFree = "Mustard-Free"
    case noOilAdded = "No oil added"
    case paleo = "Paleo"
    case peanutFree = "Peanut-Free"
    case pescatarian = "Pescatarian"
    case porkFree = "Pork-Free"
    case redMeatFree = "Red-Meat-Free"
    case sesameFree = "Sesame-Free"
    case shellfishFree = "Shellfish-Free"
    case soyFree = "Soy-Free"
    case sugarConscious = "Sugar-Conscious"
    case sulfiteFree = "Sulfite-Free"
    case treeNutFree = "Tree-Nut-Free"
    case vegan = "Vegan"
    case vegetarian = "Vegetarian"
    case wheatFree = "Wheat-Free"
    case lowwSugar = "Low Sugar"
}

// MARK: - Digest
struct Digest: Codable {
    let label, tag: String
    let schemaOrgTag: SchemaOrgTag?
    let total: Double
    let hasRDI: Bool
    let daily: Double
    let unit: Unit
    let sub: [Digest]?
}

enum SchemaOrgTag: String, Codable {
    case carbohydrateContent = "carbohydrateContent"
    case cholesterolContent = "cholesterolContent"
    case fatContent = "fatContent"
    case fiberContent = "fiberContent"
    case proteinContent = "proteinContent"
    case saturatedFatContent = "saturatedFatContent"
    case sodiumContent = "sodiumContent"
    case sugarContent = "sugarContent"
    case transFatContent = "transFatContent"
}

enum Unit: String, Codable {
    case empty = "%"
    case grams = "g"
    case kcal = "kcal"
    case mg = "mg"
    case µg = "µg"
}

// MARK: - Ingredient
struct Ingredient: Codable {
    let text: String
    let quantity: Double
    let measure: String?
    let food: String
    let weight: Double
    let foodCategory: String?
    let foodID: String?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case text, quantity, measure, food, weight, foodCategory
        case foodID = "foodId"
        case image
    }
}

enum CuisineType: String, Codable, CaseIterable {
    case american = "american"
    case asian = "asian"
    case british = "british"
    case caribbean = "caribbean"
    case centralEurope = "central europe"
    case chinese = "chinese"
    case easternEurope = "eastern europe"
    case french = "french"
    case greek = "greek"
    case indian = "indian"
    case italian = "italian"
    case japanese = "japanese"
    case korean = "korean"
    case kosher = "kosher"
    case mediterranean = "mediterranean"
    case mexican = "mexican"
    case middleEastern = "middle eastern"
    case nordic = "nordic"
    case southAmerican = "south american"
    case southEastAsian = "south east asian"
    case world = "world"
}

enum MealType: String, Codable, CaseIterable {
    case breakfast = "breakfast"
    case dinner = "dinner"
    case lunch = "lunch"
    case snack = "snack"
    case teatime = "teatime"
    case lunchDinner = "lunch/dinner"
    case brunch = "brunch"
    
    static var allCases: [MealType] {
        return [.breakfast, .dinner, .lunch, .snack, .teatime, .brunch]
    }
}

enum DishType: String, Codable, CaseIterable {
    case alcoholCocktail = "alcohol cocktail"
    case biscuitsAndCookies = "biscuits and cookies"
    case bread = "bread"
    case cereals = "cereals"
    case condimentsAndSauces = "condiments and sauces"
    case desserts = "desserts"
    case drinks = "drinks"
    case mainCourse = "main course"
    case pancake = "pancake"
    case preps = "preps"
    case preserve = "preserve"
    case salad = "salad"
    case sandwiches = "sandwiches"
    case sideDish = "side dish"
    case soup = "soup"
    case starter = "starter"
    case sweets = "sweets"
    case christmas = "christmas"
    case specialOccasions = "special occasions"
    case omelet = "omelet"
    case egg = "egg"
    case thanksgiving = "thanksgiving"
    case halloween = "halloween"
    case unknown

    static var allCases: [DishType] {
        return [
            .alcoholCocktail, .biscuitsAndCookies, .bread, .cereals, .condimentsAndSauces, .desserts, 
                .drinks, .mainCourse, .pancake, .preps, .preserve, .salad, .sandwiches, .sideDish,
                .soup, .starter, .sweets, .christmas, .specialOccasions, .omelet, .egg, .thanksgiving, .halloween
        ]
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try? container.decode(String.self)
        self = DishType(rawValue: rawValue ?? "") ?? .unknown
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.rawValue)
    }
}

// MARK: - Total
struct Total: Codable {
    let label: String
    let quantity: Double
    let unit: Unit
}
