
import UIKit
/*:
 # Functional Programming with Swift
 
 ## Why Should You Use It?
 * Greater Productivity
 * Produces shorter programs in quicker time
 * Greater Modularity
 * Encourages singular purpose functions and resuablility
 * Easier To Test
 * Learning a new paradigm forces you to think differently
 
 ## Using Closures
 
 Closures are self-contained blocks of functionality that can be passed around. Similar to lambdas in other languages.
 
 > *Closure expressions* are a way to write inline closures in a brief, focused syntax.
 
 ````
 { (parameters) -> return type in
 statements
 }
 ````
 
 We will use the `sorted(by:)` function from Swift's standard library to show a small example of how functional programming is done with closures.
 
 The `sorted(by:)` function sorts an array of values based on the output of a sorting closure that you provide.
 */
let names = ["John", "Chris", "Jared", "Alex", "Jason"]
/*:
 ## The Normal Way
 
 The typical way to implement the sort is to define a normal sorting function, and then pass it to the `sorted(by:)` method.
 */
func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}

let reversedNames = names.sorted(by: backward)
/*:
 ## A Better Approach: Using a Closure Expression
 
 Note the declaration of parameters and return type for the closure is identical to the `backward()` function. Instead of using a named fucntion we replaced with an anonymous funciton!
 */
var sortedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s2 > s1
})
/*:
 ## Even Better Approach: Inferring Type From Context
 > Swift can infer the types of its parameters and the type of the value it returns.
 This means we don't need to include type information!
 */
sortedNames = names.sorted(by: { (s1, s2) in return s2 > s1 })
sortedNames
/*:
 ## Better and Cleaner Approach: Implicit Returns from Single-Expression Closures
 If the closure is a single expression you can implicitly return the result by omitting the `return` keyword!
 */
sortedNames = names.sorted(by: { s1, s2 in s2 > s1 })
sortedNames
/*:
 ## Final Evolution: Shorthand Argument Names
 Swift automatically provides shorthand argument names to inline closures, which can be used to refer to the values of the closure’s arguments by the names $0, $1, $2, and so on.
 > If you use these shorthand argument names within your closure expression, you can omit the closure’s argument list from its definition!
 
 Using the previous techniques shown with shorthand arguments you can rewrite the sorted closure very concisely!
 */
sortedNames = names.sorted(by: { $1 > $0 })
sortedNames
//: ![Mind Blown](tim-and-eric-mind-blown.gif)

