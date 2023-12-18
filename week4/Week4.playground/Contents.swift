import Foundation

// Week 3 average
let numsWeek3 = Array(0...20)
numsWeek3.forEach { if $0 % 2 == 0 { print($0) } }

func week3Average(numbers: [Int]?) {
    guard let nums = numbers, !nums.isEmpty else {
        print("The array is nil. Calculating the average is impossible.")
        return
    }
    let sum = nums.reduce(0, +)
    let avg = Double(sum) / Double(nums.count)
    print("The average of the values in the array is \(avg).")
}

// a) Overloaded functions for average

// Overloaded function using variadic parameters
func average(_ numbers: Int...) {
    week3Average(numbers: numbers)
}

// Overloaded function using non-optional array of Int
func average(numbers: [Int]) {
    week3Average(numbers: numbers)
}

// Testing the functions
average(numbers: [1, 2, 3, 4, 5]) // Non-optional array version
average(1, 2, 3, 4, 5) // Variadic parameters version
week3Average(numbers: nil) // Optional array version (original from Module 3)

// b) Enum and function for animal sounds
enum Animal {
    case cow, dog, cat, lion, horse
}

func theSoundMadeBy(animal: Animal) -> String {
    switch animal {
    case .cow: return "A cow goes moooo."
    case .dog: return "A dog goes woof."
    case .cat: return "A cat goes meow."
    case .lion: return "A lion goes roar."
    case .horse: return "A horse goes neigh."
    }
}

print(theSoundMadeBy(animal: .cow))
print(theSoundMadeBy(animal: .cat))

// c) Functions using closures and collections
let nums = Array(0...100)
let numsWithNil: [Int?] = [79, nil, 80, nil, 90, nil, 100, 72]
let numsBy2 = Array(stride(from: 2, through: 100, by: 2))
let numsBy4 = Array(stride(from: 4, through: 100, by: 4))

func evenNumbersArray(numbers: [Int]) -> [Int] {
    numbers.filter { $0 % 2 == 0 }
}

print("Even Numbers: \(evenNumbersArray(numbers: nums))")

func sumOfArray(numbers: [Int?]) -> Int {
    numbers.compactMap { $0 }.reduce(0, +)
}

print("Sum of Array: \(sumOfArray(numbers: numsWithNil))")

func commonElementsSet(_ array1: [Int], _ array2: [Int]) -> Set<Int> {
    Set(array1).intersection(Set(array2))
}

print("Common Elements: \(commonElementsSet(numsBy2, numsBy4))")

// d) Square struct
struct Square {
    var sideLength: Double
    var area: Double {
        sideLength * sideLength
    }
}

let square = Square(sideLength: 5)
print("Area of the square: \(square.area)")

// Part 3 - Above and Beyond

protocol Shape {
    func calculateArea() -> Double
}

struct Circle: Shape {
    var radius: Double
    func calculateArea() -> Double {
        Double.pi * radius * radius
    }
}

struct Rectangle: Shape {
    var width: Double
    var height: Double
    func calculateArea() -> Double {
        width * height
    }
}

let circle = Circle(radius: 3)
print("Area of circle: \(circle.calculateArea())")

let rectangle = Rectangle(width: 4, height: 5)
print("Area of rectangle: \(rectangle.calculateArea())")

// Extending protocol Shape
extension Shape {
    func calculateVolume() -> Double {
        // Default implementation
        0
    }
}

struct Sphere: Shape {
    var radius: Double
    func calculateArea() -> Double {
        4 * Double.pi * radius * radius
    }
    func calculateVolume() -> Double {
        (4/3) * Double.pi * radius * radius * radius
    }
}

let sphere = Sphere(radius: 4)
print("Area of sphere: \(sphere.calculateArea())")
print("Volume of sphere: \(sphere.calculateVolume())")
