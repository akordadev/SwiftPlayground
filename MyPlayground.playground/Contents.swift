//: Playground - noun: a place where people can play

import UIKit


let NUMBER: Int = 10;

var str = "Hello world";
var number = 20;


var x = 20
x = 30

//constants
let tup: (day: Int, month: Int, year: Int) = (10, 10, 10)
let day = tup.day

let tuple = (100, 1.5, 10)
let value = tuple.1

func multiply(x: Int, y: Int) -> Int {
    return x * y
}
multiply(5, y: 6)

//pointers
func pointer(inout x: Int) {
    x++
    print(x)
}
var test = 6
pointer(&test)
print(test)

//recursion
func fibonacci(x: Int) -> Int {
    if(x <= 2) {
        return 1;
    }
    return fibonacci(x - 1) + fibonacci(x - 2)
}

fibonacci(1)  // = 1
fibonacci(2)  // = 1
fibonacci(3)  // = 2
fibonacci(4)  // = 3
fibonacci(5)  // = 5
fibonacci(10) // = 55

//closures
func operateOnNumbers(a: Int, _ b: Int, operation: (Int, Int) -> Int) -> Int {
    let result = operation(a, b)
    print(result)
    return result
}
//notice "in" keyword, and "return" keyword is optional
let addOp = { (a: Int, b: Int) in
    a + b
}
operateOnNumbers(4, 2, operation: addOp)
operateOnNumbers(4, 2) {
    $0 * $1
}

//nil aka null

let authorName: String? = "Matt Galloway"
let authorAge: Int? = 30
//regular if
if authorName != nil {
    
}
//if let
if let name: String = authorName, age: Int = authorAge {
    print("The author is \(name) who is \(age) years old.")
} else {
    print("No author or no age.")
}

//arrays
var scores = [2, 2, 8, 6, 1, 2]
var names = ["hello", "world"]
//reduce explaination...   http://ijoshsmith.com/2014/06/25/understanding-swifts-reduce-method/
scores.reduce(0, combine: +)
let filterScores = scores.filter({ $0 > 5 })
print(filterScores)
let newScores = scores.map({ $0 * 2})
print(newScores)

let a1 = [Int]()
let a2 = []
let a3: [String] = ["test", "test2"]

//generics example
func reverse<T>(inout array: [T]) {
    for var i = 0; i < array.count / 2; i++ {
        let item = array[i]
        array[i] = array[array.count - 1 - i]
        array[array.count - 1 - i] = item
    }
}
reverse(&scores)
reverse(&names)

//dictionaries
let dict = Dictionary<String, Int>()
let shortDict = [String: Int]()

let namesAndScores = ["Anna": 2, "Brian": 2, "Craig": 8, "Donna": 6]
// $0 is partially-combined result, $1 is current element, where $1.0 is the dictionary key
let nameString = namesAndScores.reduce("", combine: { $0 + "\($1.0), "})
nameString

//sets, like hashsets
var myTimes: Set = ["8am", "9am", "10am"]

//structs (ints/strings etc. are structs, and stored on stack)
struct Grade {
    let letter: String
    let points: Double
    let credits: Double
}

struct Order {
    var toppings: [String]
    var size: String
    var crust: String
    //computed properties are not stored in memory
    var computedProperty: String {
        return size + crust
    }
    //all struct non-optional (?) properties must be set in each init
    init(toppings: [String], size: String, crust: String) {
        self.toppings = toppings
        self.size = size
        self.crust = crust
    }
    init(size: String, crust: String) {
        self.toppings = ["Cheese"]
        self.size = size
        self.crust = crust
    }
    init(special: String) {
        self.size = "Large"
        self.crust = "Regular"
        if special == "Veggie" {
            self.toppings = ["Tomatoes", "Green Pepper", "Mushrooms"]
        } else if special == "Meat" {
            self.toppings = ["Sausage", "Pepperoni", "Ham", "Bacon"]
        } else {
            self.toppings = ["Cheese"]
        }
    }
    func changeImmutableProperties(size: String) {
        //can't change structs without mutating clause... structs are immutable
        //self.size = size
    }
    mutating func changeProperties(size: String) {
        self.size = size
    }
}

var order = Order(size: "large", crust: "stuffed")
//extension methods, can define extension methods to any class or struct
extension String {
    func evenOrOdd() -> String {
        return characters.count % 2 == 0 ? "Even!" : "Odd!"
    }
}

//classes (data stored on heap, pointer on stack)
class Person {
    var firstName: String
    var lastName: String
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    func fullName() -> String {
        return "\(firstName) \(lastName)"
    }
    final func cannotOverride() {
        
    }
    //called when reference count is 0
    deinit {
        print("\(firstName) \(lastName) is being removed from memory!")
    }
}
//use === to check reference equality, instead of == (value equality)
var john = Person(firstName: "John", lastName: "Appleseed")
var imposter = Person(firstName: "John", lastName: "Appleseed")
var homeOwner = john
print( john === homeOwner ) // true
print( john === imposter ) // false
print( imposter === homeOwner ) // false
homeOwner = imposter
print ( john === homeOwner ) // false
homeOwner = john
print ( john === homeOwner ) // true

//inheritance
class Student: Person {
    var studentId: Int
    var grades: [Grade] = []
    //reference count will not be increased during assignment...
    //this means no memory leak when you nil out the container student
    weak var partner: Student?
    //requires sub classes to define this
    override required init(firstName: String, lastName: String) {
        grades = []
        studentId = 0
        super.init(firstName: firstName, lastName: lastName)
    }
    //this method is convenient to initialize a class, must call required init
    convenience init(transfer: Student) {
        self.init(firstName: transfer.firstName, lastName: transfer.lastName)
    }
    deinit {
        print("\(firstName) \(lastName) is being removed from memory!")
    }
}
class StudentAthlete: Student {
    var sport: String
    
    init(sport: String) {
        self.sport = sport
        super.init(firstName: "test", lastName: "last")
    }

    //required, due to super class definition of init
    required init(firstName: String, lastName: String) {
        self.sport = ""
        super.init(firstName: firstName, lastName: lastName)
    }
}
class StarStudentAthlete: StudentAthlete {
    var extraStuff: Int
    
    init(x: Int) {
        self.extraStuff = x
        super.init(sport: "test")
    }
    required init(firstName: String, lastName: String) {
        self.extraStuff = 10
        super.init(firstName: firstName, lastName: lastName)
    }
}
func phonebookName(person: Person) -> String {
    return "\(person.lastName), \(person.firstName)"
}
let person = Person(firstName: "Johnny", lastName: "Appleseed")
let star = StarStudentAthlete(x: 10)
print( phonebookName(person) ) // Appleseed, John
print( phonebookName(star) ) // Appleseed, Jane

//prevent inheritance
final class CantInherit {
    
}

//reference counting
// Person object has a reference count of 1 (john variable)
var johnny = Person(firstName: "Johnny", lastName: "Appleseed")
// Reference count 2 (john, anotherJohn)
var anotherJohn: Person? = johnny
// Reference count 6 (john, anotherJohn, 4 references)
// The same reference is inside both john and anotherJohn
var lotsaJohns = [johnny, johnny, anotherJohn, johnny]
// Reference count 5 (john, 4 references in lotsaJohns)
anotherJohn = nil
// Reference count 1 (john)
lotsaJohns = []
// Reference count 0!
johnny = Person(firstName: "Johnny", lastName: "Appleseed")

//optionals and deinit memory leak example
//? is optional chaining, ! is forced unwrapping
var jim: Student? = Student(firstName: "Jim", lastName: "Appleseed")
var jane: Student? = Student(firstName: "Jane", lastName: "Appleseed")
jim?.partner = jane
jane?.partner = jim
jim = nil
jane = nil
//deinit will only be called if parnter is "weak" in the Student class

//enums
enum MonthOtherSyntax {
    case January
    case February
    case March
    case April
    case May
    case June
    case July
    case August
    case September
    case October
    case November
    case December
}
enum Month: Int {
    case January = 1, February, March, April, May, June,
    July, August, September, October, November, December
    
    init() {
        self = .January
    }
    func monthsUntilWinterBreak() -> Int {
        return Month.December.rawValue - self.rawValue
    }
}
let month = Month.October
let defaultMonth = Month()
let monthsLeft = month.monthsUntilWinterBreak()

//enums with args
var balance = 100
enum WithdrawalResult {
    case Success(Int)
    case Error(String)
}
func withdraw(amount: Int) -> WithdrawalResult {
    if (amount <= balance) {
        balance -= amount
        return .Success(balance)
    } else {
        return .Error("Not enough money!")
    }
}
let result = withdraw(99)
switch result {
    case let .Success(newBalance):
        print("Your new balance is: \(newBalance)")
    case let .Error(message):
        print(message)
}
//let optionalNil: Optional<Int> = .None
let optionalNil: Int? = .None
optionalNil == nil    // true
optionalNil == .None  // true

//computed properties, with get and set
struct TV {
    var height: Double
    var width: Double
    // 1
    //diagonal is not stored in memory, the setter only sets values of height and width.
    var diagonal: Int {
        // 1
        get { // 2
            return Int(round(sqrt(height * height + width * width)))
        }
        set { // 3
            let ratioWidth: Double = 16
            let ratioHeight: Double = 9
            // 4
            height = Double(newValue) * ratioHeight /
                sqrt(ratioWidth * ratioWidth + ratioHeight * ratioHeight)
            width = height * ratioWidth / ratioHeight
        }
    }
}
//static property, property observer
struct Level {
    static var highestLevel = 1
    let id: Int
    var boss: String
    var unlocked: Bool {
        didSet {
            if unlocked && id > Level.highestLevel {
                Level.highestLevel = id
            }
        }
    }
}
Level.highestLevel
//use of oldValue in property obsesrver
class LightBulb {
    static let maxCurrent = 40
    var currentCurrent = 0 {
        didSet {
            if currentCurrent > LightBulb.maxCurrent {
                print("Current too high, falling back to previous setting.")
                currentCurrent = oldValue
            }
        } }
}

//singleton pattern
class GameManager {
    // 1
    static let defaultManager = GameManager()
    var gameScore = 0
    var saveState = 0
    // 2
    private init() {}
}

//lazy properties (lazy loading)
class Circle {
    lazy var pi = {
        return ((4.0 * atan(1.0 / 5.0)) - atan(1.0 / 239.0)) * 4.0
    }()
    var radius: Double = 0
    var circumference: Double {
        return pi * radius * radius
    }
    init (radius: Double) {
        self.radius = radius
    }
}
//private setter
class Car {
    let make: String
    private(set) var color: String
    init() {
        make = "Ford"
        color = "Black"
    }
    required init(make: String, color: String) {
        self.make = make
        self.color = color
    }
    func paint(color c: String) {
        self.color = c
    }
}

//protocols, much like interfaces
protocol Vehicle {
    var weight: Int { get }
    var name: String { get set }
    func accelerate()
    func stop()
}
//typealias
protocol WeightCalculatable {
    typealias WeightType
    func calculateWeight() -> WeightType
}
class HeavyThing: WeightCalculatable {
    // This heavy thing only needs integer accuracy
    typealias WeightType = Int
    func calculateWeight() -> Int {
        return 100 }
}
class LightThing: WeightCalculatable {
    // This light thing needs decimal places
    typealias WeightType = Double
    func calculateWeight() -> Double {
        return 0.0025
    }
}
//extensions and protocols, can also use extension definition to implement methods/properties of a protocol
protocol WhatType {
    var typeName: String { get }
}
extension String: WhatType {
    var typeName: String {
        return "I'm a String"
    }
}
let myType: WhatType = "Swift by Tutorials!"
myType.typeName // I'm a String
"hello".typeName

//extending equals
struct Record {
    var wins: Int
    var losses: Int
}
extension Record: Equatable {}
func ==(lhs: Record, rhs: Record) -> Bool {
    return lhs.wins == rhs.wins && lhs.losses == rhs.losses
}
extension Record: Comparable {}
func <(lhs: Record, rhs: Record) -> Bool {
    let lhsPercent = Double(lhs.wins) / (Double(lhs.wins) +
        Double(lhs.losses))
    let rhsPercent = Double(rhs.wins) / (Double(rhs.wins) +
        Double(rhs.losses))
    return lhsPercent < rhsPercent
}
let recordA = Record(wins: 10, losses: 5)
let recordB = Record(wins: 10, losses: 5)
recordA == recordB // Build error if equatable is not implemented!

let team1 = Record(wins: 23, losses: 8)
let team2 = Record(wins: 23, losses: 8)
let team3 = Record(wins: 14, losses: 11)
team1 < team2 // false
team1 > team3 // true

extension Student: Equatable { }
func ==(lhs: Student, rhs: Student) -> Bool {
    return lhs.lastName == rhs.lastName
}

//extending hashable
extension Student: Hashable {
    var hashValue: Int {
        return studentId
    }
}

let johnStudent = Student(firstName: "Johnny", lastName: "Appleseed")
// Dictionary
let lockerMap: [Student: String] = [johnStudent: "14B"]
// Set
let classRoster: Set<Student> = [johnStudent, johnStudent, johnStudent, johnStudent]
classRoster.count // 1

//customize print statements
extension Record: CustomStringConvertible {
    var description: String {
        return "\(wins) - \(losses)"
    }
}
let record = Record(wins: 23, losses: 8)
print(record)

//default protocol implementation
protocol TeamRecord {
    var wins: Int { get }
    var losses: Int { get }
    func winningPercentage() -> Double
}
extension TeamRecord {
    func winningPercentage() -> Double {
        return Double(wins) / (Double(wins) + Double(losses))
    }
}
//type constraints
protocol PlayoffEligible {
    var minimumWinsForPlayoffs: Int { get }
}
extension TeamRecord where Self: PlayoffEligible {
    func isPlayoffEligible() -> Bool {
        return self.wins > minimumWinsForPlayoffs
    }
}

enum Direction {
    case Left
    case Right
    case Forward
}
//Error handling, and failable initializers

enum RollingError: ErrorType {
    case Doubles
    case OutOfFunding
}
var hasFunding = true
func roll(firstDice: Int, secondDice: Int) throws {
    let error: RollingError
    if firstDice == secondDice && hasFunding { // 1
        error = .Doubles
        hasFunding = false
        throw error
    } else if firstDice == secondDice && !hasFunding { // 2
        hasFunding = true
        print("Huzzah! You raise another round of funding!")
    } else if !hasFunding { // 3
        error = .OutOfFunding
        throw error
    } else { // 4
        print("You moved \(firstDice + secondDice) spaces")
    }
}

enum PugBotError: ErrorType {
    case DidNotTurnLeft(directionMoved: Direction)
    case DidNotTurnRight(directionMoved: Direction)
    case DidNotGoForward(directionMoved: Direction)
    case EndOfPath
}
class PugBot {
    let name: String
    let correctPath: [Direction]
    var currentStepInPath = 0
    //failable initializer
    init? (name: String, correctPath: [Direction]) {
        self.correctPath = correctPath
        self.name = name
        // 1
        guard (correctPath.count > 0) else {return nil}
        // 2
        switch name {
        case "Delia", "Olive", "Frank", "Otis", "Doug":
            break
        default:
            return nil
        }
    }
    //advanced error handling...
    func movePugBotSafely(move:() throws -> ()) -> String {
        do {
            try move()
            return "Completed move successfully."
        } catch PugBotError.DidNotTurnLeft(let directionMoved) {
            return "The PugBot was supposed to turn left, but turned \(directionMoved) instead."
        } catch PugBotError.DidNotTurnRight(let directionMoved) {
            return "The PugBot was supposed to turn right, but turned \(directionMoved) instead."
        } catch PugBotError.DidNotGoForward(let directionMoved) {
            return "The PugBot was supposed to move forward, but turned \(directionMoved) instead."
        } catch PugBotError.EndOfPath() {
            return "The PugBot tried to move past the end of the path."
        } catch {
            return "An unknown error occurred"
        }
    }
}

//functional programming
func capitalize(s: String) -> String {
    return s.uppercaseString
}
func map<InputType, OutputType>(inputs: [InputType], transform: (InputType)->(OutputType)) -> [OutputType] {
    var outputs:[OutputType] = []
    for inputItem in inputs {
        let outputItem = transform(inputItem)
        outputs.append(outputItem)
    }
    return outputs
}
let animals = ["cat", "dog", "sheep", "dolphin", "tiger"]
let uppercaseAnimals2 = map(animals, transform: capitalize)