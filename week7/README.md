# Week 7 Homework

## Part 1 - Short Answer Questions

### a) The ________ __________ class allows you to interact with the file system and its contents.
- `FileManager`; `default`.

### b) Apps on iOS are _________________ from each other.
- sandboxed.

### c) True or False:
FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] will give the document directories for all Apps the user has on their device.
- False.

### d) The _______________ folder is a good place to put re-usable code when using Playgrounds.
- `Sources`.

### e) What URL property allows you to view the URL’s path?
- `.path`. `appendingPathComponent(_:)` allows you to add a file name to a directory.

### f) Name at least three Swift Data Types you have used up to this point in the bootcamp.
- `String`, `Int`, `Bool`.

### g) How can you find the number of bytes a Data Type uses?
- Using `MemoryLayout<Type>.size`.

### h) Using Playgrounds, how can you tell that the Data.write operation succeeded?
- No error is thrown.

### i) You can mostly treat Data objects like _______________ of bytes.
- collections.

### j) The write and read methods of Data require a _______________.
- URL.

### k) What JavaScript calls an object is the same concept as a heterogenous _____________ in Swift with __________________ for keys.
- `Dictionary`; `String`.

### l) How do you resolve the error: Use of unresolved identifier ‘Bundle’?
- Import the Foundation framework.

### m) Give an example of Snake Case.
- `snake_case`.

### n) A struct that will be used in the reading and writing of data must conform to the __________________ Protocol.
- `Codable`.

### o) Show the line of code used to access the user’s document directory for the running app.
- `FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]`.

### p) Files added to the project that will be used by the app can be found in the __________ _________ when the app is running.
- `Bundle`; `main`.