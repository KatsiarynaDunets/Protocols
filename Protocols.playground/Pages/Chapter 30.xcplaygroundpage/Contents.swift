import UIKit

protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

protocol AnotherProtocol {
    static var someTypeProperty: Int { get }
}

struct SomeStruct: SomeProtocol {
    var mustBeSettable: Int
    let doesNotNeedToBeSettable: Int
    // дополнительный метод, не описанный в протоколе
    func getSum() -> Int {
        return self.mustBeSettable + self.doesNotNeedToBeSettable
    }
}

struct AnotherStruct: SomeProtocol, AnotherProtocol {
    var mustBeSettable: Int
    let doesNotNeedToBeSettable: Int
    static var someTypeProperty: Int = 3
    func getSum() -> Int {
        return self.mustBeSettable
            + self.doesNotNeedToBeSettable
            + AnotherStruct.someTypeProperty
    }
}

protocol RandomNumberGenerator {
    var randomCollection: [Int] { get set }
    func getRandomNumber() -> Int
    mutating func setNewRandomCollection(newValue: [Int])
}

struct RandomGenerator: RandomNumberGenerator {
    var randomCollection: [Int] = [1, 2, 3, 4, 5]
    func getRandomNumber() -> Int {
        return randomCollection.randomElement()!
    }

    mutating func setNewRandomCollection(newValue: [Int]) {
        self.randomCollection = newValue
    }
}

class RandomGeneratorClass: RandomNumberGenerator {
    var randomCollection: [Int] = [1, 2, 3, 4, 5]
    func getRandomNumber() -> Int {
        if let randomElement = randomCollection.randomElement() {
            return randomElement
        }
        return 0
    }

    // не используется модификатор mutating
    func setNewRandomCollection(newValue: [Int]) {
        self.randomCollection = newValue
    }
}

//protocol Named {
//    init(name: String)
//}
//class Person: Named {
//    var name: String
//    required init(name: String) {
//        self.name = name
//    }
//}

func getHash<T: Hashable>(of value: T) -> Int {
    return value.hashValue // Такой прием называется универсальным шаблоном (generic)!
}

getHash(of: 5)
getHash(of: "Swift")

protocol HasValue {
    var value: Int { get set }
}

class ClassWithValue: HasValue {
    var value: Int
    init(value: Int) {
        self.value = value
    }
}

struct StructWithValue: HasValue {
    var value: Int
}

// коллекция элементов
let objects: [Any] = [
    2,
    StructWithValue(value: 3),
    true,
    ClassWithValue(value: 6),
    "Kate"
]

for object in objects {
    if let elementWithValue = object as? HasValue {
        print("Значение \(elementWithValue.value)")
    }
}

for object in objects {
    print(object is HasValue)
}

import Foundation
protocol GeometricFigureWithXAxis {
    var x: Int { get set }
}

protocol GeometricFigureWithYAxis {
    var y: Int { get set }
}

protocol GeometricFigureTwoAxis: GeometricFigureWithXAxis,
    GeometricFigureWithYAxis
{
    var distanceFromCenter: Float { get }
}

struct Figure2D: GeometricFigureTwoAxis {
    var x: Int = 0
    var y: Int = 0
    var distanceFromCenter: Float {
        let xPow = pow(Double(self.x), 2)
        let yPow = pow(Double(self.y), 2)
        let length = sqrt(xPow + yPow)
        return Float(length)
    }
}

// MARK: Классовые протоколы

// protocol SuperProtocol { }
// protocol SubProtocol: class, SuperProtocol { }
// class  ClassWithProtocol: SubProtocol { } // корректно
// struct StructWithProtocol: SubProtocol { } // - ошибка

protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct Person: Named, Aged {
    var name: String
    var age: Int
}

func wishHappyBirthday(celebrator: Named & Aged) {
    print("С Днем рождения, \(celebrator.name)! Тебе уже \(celebrator.age)!")
}

let birthdayPerson = Person(name: "Kate", age: 27)
wishHappyBirthday(celebrator: birthdayPerson)


