# Module 1 - Short-answer Questions

### a) What does the command ‘git status’ output?
Shows changes in your project.

### b) In SwiftUI, anything that gets drawn on the screen is a __________________.
`View`.

### c) `print(“Hello world”)` is an example of a __________________ call.
Function.

`viewModel.getData()` is an example of a __________________ call.
Method.

### d) Name some Views you have seen so far in SwiftUI.
Text, Button, Image.

### e) How do you create a new local repository using git?
Use `git init`.

### f) How do you preview your app in multiple orientations?
Use Xcode's preview tools.

### g) An app is made up of ________________ of classes and structs that contain ______________ and _________________.
Collections; properties; methods.

### h) Name two components of a SwiftUI Button.
Label and action.

### i) In git, what is the difference between a local repository and a remote repository?
Local is on your computer; remote is online.

### j) Give an example of camel case.
`myVariableName`.

### k) What is a branch in git, and how do you create one?
A separate line of work. Create with `git branch [name]`.

### l) What are some common mistakes that can lead to errors while programming?
Typos, logical errors, forgetting updates.

### m) VStack, HStack, and ZStack are __________________ views used for ________________.
Stack; arranging.

### n) How do you list the branches on your local repository?
Use `git branch`.

### o) What happens when @State variable changes in SwiftUI?
The view updates.

### p) What is the Single Responsibility Principle?
One class, one job.

### q) What will the print statement below produce?
`print(“Hello, \(name)!")` shows “Hello, Ozma!”

### r) What commands can you use in git to download data from a remote repository? What commands can you use in git to send data to a remote repository?
Download with `git pull`, send with `git push`.

### s) Why is a programming To-Do list important, and what is a minimum viable product?
To-Do: keeps organized. MVP: simplest working version.

### t) What is a simple way of describing Binding in SwiftUI?
Links view to data.

### u) What command do you use in git to move changes from one branch to another?
Use `git merge` or `git rebase`.

### v) What is the type of the variable defined below?
`var a = 87` is an `Int`.

### w) What is the difference between var and let?
`var` for variables, `let` for constants.

# Module 2 - Short-answer Questions

### a) Describe the two size classes in iOS.
iOS has two size classes - Compact and Regular. Compact is used for narrower spaces like iPhones in portrait mode, and Regular is for wider spaces like iPads.

### b) What is Continuous Learning, and why is it important in mobile development?
Continuous learning is constantly improving one's skills and knowledge. It's important because of quickly evolving technologies and user expectations.

### c) How can you find out what modifiers a View has?
To determine the modifiers applied to a View in SwiftUI, you need to inspect the code where the View is defined, as SwiftUI uses a declarative syntax where modifiers are listed in the View's code.

### d) What is a breakpoint?
A breakpoint is a debugging tool used in software development. It allows developers to pause program execution at a specific point to examine the current state of the system.

### e) How can you access environment values in your App?
Environment values in SwiftUI can be accessed using the `@Environment` property wrapper, which lets you access system-wide information like interface style and layout direction.

### f) How can you determine, in code, if the App is in Dark or Light Mode?
You can check the color scheme using the `@Environment(\.colorScheme)` property wrapper, which tells you if the app is currently in Dark or Light Mode.

### g) Why are magic numbers an issue, and how should you avoid them?
Magic numbers are hard-coded values without clear meaning or context. They are an issue because they make code hard to read and maintain. Use named constants instead for clarity.

### h) How can you view your App in Light and Dark Modes simultaneously?
Add a new ContentView in previews and add a dark interface modifier

### i) Below is an image of the Canvas from Xcode. The Canvas is in selectable mode. Can you explain why the red background does not cover the entire button area?
The red background does not cover the entire button area because the background modifier is applied only to the Text view within the Button, not to the Button view itself.
Fill was added before padding

### j) Modifier padding(10) adds padding to the view's top, bottom, left, and right sides. How could a padding of 10 be added to only the left and right sides of the view? The answer for this question should be a short section of code.
```swift
.padding(.horizontal, 10)
```
This adds padding of 10 points to the left and right sides of the view.

### k) Provide two reasons why you would want to extract views.
1. Reusability: To use the same view in multiple places.
2. Readability: To make the code more organized and easier to read.

### l) How can you determine, in code, if the device is in Portrait or Landscape mode?
You can check the device orientation using the `UIDevice.current.orientation` property in UIKit or `@Environment(\.sizeClass)` in SwiftUI.

### m) What is a literal value?
A literal value is a value that appears directly in the source code, like a number (e.g., 8), a string (e.g., "Hi"), or a boolean (e.g., true).

### o) What are the safe areas?
Safe areas are the areas of a screen not covered by the status bar, navigation bar, tab bar, or other UI elements. They ensure content is visible and interactable.

### p) This line of code was in the lesson on animation. Can you state in English what the line means?
`.frame(width: wideShapes ? 200 : 100)`
This line sets the frame width of a view to 200 if `wideShapes` is true, otherwise to 100.
 
### q) Describe the two transitions you were introduced to in this week’s lesson.
 easeInOut and scale

### r) In Bullseye, the Game struct is what type of object?
In the Bullseye game, the `Game` struct is a data model that holds the game's state and logic.

### s) What are SFSymbols?
SFSymbols are a set of 2400+ configurable symbols integrated into iOS, provided by Apple for use in app development.

### t) What is the difference between “step into” and “step over " in the debugger?
- "Step Into": Goes into the details of a function call.
- "Step Over": Executes the current line of code without going into details.

### u) Name some items you would place in the Asset Catalog (Assets.)
Images, colors, icons, and other media assets used in the app.

### v) How do you change the Display Name of your app?
Change the Display Name in the app's Info.plist file by setting the `CFBundleDisplayName` key.
