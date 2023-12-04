
# Week 3 Homework

## Part 1 - Short Answer Questions

### a) 0…5 and 0..<5 are two types of ____________. How are they different?
These are two types of range operators in Swift.
- `0...5` is a closed range, including all values from 0 to 5 (0, 1, 2, 3, 4, 5).
- `0..<5` is a half-open range, including 0 up to but excluding 5 (0, 1, 2, 3, 4).

### b) Describe type inference in Swift and give an example.
Type inference in Swift is where the compiler automatically deduces the type of a variable or constant based on the assigned value.
- Example: Writing `let number = 10` lets Swift infer that `number` is of type `Int`.

### c) List three advantages of Playgrounds.
Three advantages of Playgrounds in Swift:
1. Immediate feedback: You can see the results of your code instantly.
2. Experimentation: Easy testing and experimentation.
3. Learning tool: Great for learning and understanding Swift syntax and features.

### d) When does the execution of a while loop end?
A while loop's execution ends when its condition becomes false.

### e) True or False: Tuples in Swift can contain values of different data types.
True

### f) List three data types you have used in Swift.
Int, String, Bool

### g) To execute alternative code when the condition of an if statement is not met, you can use what clause?
Else clause

### h) What is the third element of the array nums defined below?  
let nums = [5, 0, 44, 20, 1].
The third element of the array `nums` is 44.

### i) An ____________ is a unit of code that resolves to a single value.
Expression

### j) Define two ways to unwrap optionals in Swift.
Two ways to unwrap optionals in Swift:
1. Optional binding (using if let or guard let).
2. Forced unwrapping (using the ! operator).

### k) True or False: The condition in an if statement must be true or false.
True

### l) Arrays in Swift are ____________ indexed.
Arrays in Swift are zero indexed.

### m) An unordered collection of unique values of the same type is a _____________.
An Set

## Part 3 - Above and Beyond
Modifying square2 does not affect square1 because structs are value types, and changing a copy does not affect the original.
Modifying rectangle2 does affect rectangle1 because classes are reference types, and changing a reference changes the original object.
