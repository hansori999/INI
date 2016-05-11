//
//  main.swift
//  Initialization
//
//  Created by Myoung-Wan Koo on 2016. 5. 11..
//  Copyright © 2016년 Myoung-Wan Koo. All rights reserved.
//

import Foundation

print("Hello, World!")

/* */

//Initializaer Parameters without External Names
struct Celsius {
    var temperatureInCelsius: Double
    
    init(fromFahrenheit fahrenheit:Double) {
        temperatureInCelsius = (fahrenheit-32.0)/1.8
    }
    init(fromKelvin kelvin:Double){
        temperatureInCelsius = kelvin - 273.15
    }
    init( _ celsius: Double) {
        temperatureInCelsius = celsius
    }
}
let bodyTemperature = Celsius( 37.0)
print(bodyTemperature.temperatureInCelsius)


// Optinal Peoperty Types
class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
        print(response)
    }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()

cheeseQuestion.response = "Yes, I do like cheese"
cheeseQuestion.ask()

/* */

// Modifying COnstant Properties During Initialization
/*
 class SurveyQuestion {
 let text: String
 var response: String?
 init(text: String) {
 self.text = text
 }
 func ask() {
 print(text)
 print(response)
 }
 }
 let beetsQuestion = SurveyQuestion(text: "How about beets?")
 beetsQuestion.ask()
 
 beetsQuestion.response = "Yes, I do like beets"
 beetsQuestion.ask()
 
 


// Memberwise Initializers for Structure Types
struct Size{
    var width=0.0, height=0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)

// Initializer Delegation for Value Types
struct Point { var x=0.0, y=0.0 }
// Initalize in three ways
struct Rect{
    var origin = Point()
    var size = Size()
    init() { }
    init(origin: Point, size: Size){
        self.origin = origin
        self.size = size
    }
    init(center:Point, size: Size){
        let originX = center.x - (size.width/2)
        let originY = center.y - (size.height/2)
        self.init(origin:Point(x:originX, y:originY), size:size)
    }
}

let basicRect = Rect()

print(basicRect.size.width,basicRect.size.height, basicRect.origin.x, basicRect.origin.y)

let originRect = Rect(origin:Point(x:2.0, y:2.0), size: Size(width: 5.0, height: 5.0))

print(originRect.size.width,originRect.size.height, originRect.origin.x, originRect.origin.y)

let centerRect = Rect(center:Point(x:4.0, y:4.0), size: Size(width: 3.0, height: 3.0))

print(centerRect.size.width,centerRect.size.height, centerRect.origin.x, centerRect.origin.y)

/* */



// Initializer Inheriance and Overriding
class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) Wheels(s)"
    }
}
class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}
let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")

// Three Classes Hierarchy

class Food {
    var name:String
    init(name:String) {
        self.name = name
    }
    convenience init() {
        self.init(name:"[Unmamed]")
    }
}
// designated initializer
let namedMeat = Food(name:"Bason")
print(namedMeat.name)
// convenience initializer
let mysteryMeat = Food()
print(mysteryMeat.name)

//Second Class
class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name:name)
    }
    override convenience init(name:String) {
        self.init(name:name, quantity:1)
    }
}
let oneMysteryItem = RecipeIngredient()
print(oneMysteryItem.name)
let oneBacon = RecipeIngredient(name:"Bacon")
print(oneBacon.name)
let sixEggs = RecipeIngredient(name: "Eggs", quantity:6)
print(sixEggs.name)

class ShoppingListItem: RecipeIngredient {
    var purchased=false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? "✔︎" : "✖️"
        return output
    }
}

var breakfastList = [ ShoppingListItem(), ShoppingListItem(name:"Bacon"), ShoppingListItem(name:"Eggs",quantity:6),]
breakfastList[0].name = "Orange Juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}




// Failable Initializer in struct

struct Animal{
    let species: String
    init? (species: String) {
        if species.isEmpty {
            return nil
        }
        self.species = species
    }
}

/* */
let someCreature = Animal(species: "Giraffe")
if let giraffe = someCreature {
    print(" An animal was initialized with a specied of \(giraffe.species)")
}
/* */

if let giraffe = Animal(species: "Giraffe") {
    print(" An animal was initialized with a specied of \(giraffe.species)")
} else {
    print(" The anonumous creature could not be initialized with \"\" "  )
}

if let giraffe = Animal(species: "") {
    print(" An animal was initialized with a specied of \(giraffe.species)")
} else {
    print(" The anonumous creature could not be initialized with \"\" "  )
}
// Initialzation failure
//let anonymousCreature = Animal(species: "")
//if anonymousCreature == nil {
//   println(" The anonumous creature could not be initialized with \"\" "  )
//}

print("\n Failable Initializaes for Enumerations ")

// Failable Initializers for Enumerations

enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}

let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print(" This is a defined temperature unit, so initialization is succeeded")
}
let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
    print(" THis is not a defined temperarure unit, so initialization failed  ")
}

// Failable Initializers for Enumeration with Raw Values

enum TemperatureUnit1: Character {
    case Kelvin="K", Celsius = "C", Fahrenheit="F"
}

let fahrenheitUnit1 = TemperatureUnit1(rawValue: "F")

if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}

let unknownUni1 = TemperatureUnit1(rawValue: "X")
if  unknownUni1 == nil {
    print("This is not a defined temperature unit, so initialization failed.")
    
}

/* */

print("\n Failable Initializer for Class ")
// Failabel Initializaer for Class
class Product {
    let name:String!
    init? (name:String) {
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
}

if let bowTie = Product(name:"bow tie") {
    print(" The product's name is \(bowTie.name)")
}

if let bowTie1 = Product(name:""){
    print(" The product's name is \(bowTie1.name)")
} else {
    print(" The product's name is nil")
}


// Propagation of Initialization Failure
print("\n Propagation of Initialization Failure")
class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name:name)
    }
}
if let twoSocks = CartItem(name:"sock",quantity:2) {
    print(" Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}
if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
    print(" Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
    print(" Unable to initialize zero shirts")
}

if let zeroShirts1 = CartItem(name: "", quantity: 2) {
    print(" Item: \(zeroShirts1.name), quantity: \(zeroShirts1.quantity)")
} else {
    print(" Unable to initialize zero shirts1 ")
}


/* */

// Deinitialization
/*  */
struct Bank {
    static var coinsInBank = 10_000
    static func vendCoins(  numberOfCoinsToVend : Int) -> Int {
        let  numberOfCoinsToVend = min(numberOfCoinsToVend, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    static func receiveCoins(coins:Int) {
        coinsInBank += coins
    }
}

class Player {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.vendCoins(coins)
    }
    func winCoins(coins:Int) {
        coinsInPurse += Bank.vendCoins(coins)
    }
    deinit {
        Bank.receiveCoins(coinsInPurse)
    }
}

var playerOne: Player? = Player(coins:100)
print(" A new Player has joined the game with \(playerOne!.coinsInPurse)")
// prints " A new player has joined the game with 100 coins
print(" There are now \(Bank.coinsInBank) coins left in the bank")
//prints " There are now 9900 coins left in the bank

// Play has won 2,000 coins
playerOne!.winCoins(2_000)
print(" PlayerOne won 2000 coins & new has \(playerOne!.coinsInPurse) coins")
print(" The bank now only has \(Bank.coinsInBank) coins left")

// Play has now left the game
playerOne = nil
print( " PlayerOne has left the game")
print(" The bank now has \(Bank.coinsInBank) coins")
/* */
 
 */
