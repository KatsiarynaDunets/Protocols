//: [Previous](@previous)

import Foundation

// MARK: Расширения

/*

  СИНТАКСИС:
 extension ИмяРасширяемогоТипа {
     // описание новой функциональности для расширяемого типа
 }

  */

extension Double {
    var asKM: Double { return self / 1000.0 }
    var asM: Double { return self }
    var asCM: Double { return self * 100.0 }
    var asMM: Double { return self * 1000.0 }
}

let length: Double = 25 // 25 метров
length.asKM // расстояние 25 метров в километрах - 0.025
length.asMM // расстояние 25 метров в миллиметрах — 25000

extension Double {
    var asFT: Double {
        get {
            return self / 0.3048
        }
        set(newValue) {
            self = newValue * 0.3048
        }
    }
}

var distance: Double = 100 // расстояние 100 метров
distance.asFT // расстояние 100 метров в футах - 328.08 фута
// установим расстояние в футах, но оно будет сохранено в метрах
distance.asFT = 150 // 45.72 метра

extension Int {
    func repetitions(task: () -> ()) {
        for _ in 0 ..< self {
            task()
        }
    }
}

3.repetitions {
    print("Swift")
}

extension Int {
    mutating func squared() {
        self = self * self
    }
}

var someInt = 3
someInt.squared() // 9

import Foundation
struct Line {
    var pointOne: (Double, Double)
    var pointTwo: (Double, Double)
}

extension Double {
    init(line: Line) {
        self = sqrt(
            pow(line.pointTwo.0 - line.pointOne.0, 2) +
                pow(line.pointTwo.1 - line.pointOne.1, 2)
        )
    }
}

var myLine = Line(pointOne: (10, 10), pointTwo: (14, 10))
var lineLength = Double(line: myLine) // 4

extension Int {
    subscript(digitIndex: Int) -> Int {
        var base = 1
        var index = digitIndex
        while index > 0 {
            base *= 10
            index -= 1
        }
        return (self / base) % 10
    }
}

746381295[0] // 5
746381295[1] // 9

protocol TextRepresentable {
    func asText() -> String
}

extension Int: TextRepresentable {
    func asText() -> String {
        return String(self)
    }
}

5.asText() // "5"

protocol Descriptional {
    func getDescription() -> String
}

// расширение протокола и указание реализации метода по умолчанию
extension Descriptional {
    func getDescription() -> String {
        return "Описание объектного типа"
    }
}

// подпишем класс на протокол
class myClass: Descriptional {}
// вызовем метод
print(myClass().getDescription())

class myStruct: Descriptional {
    func getDescription() -> String {
        return "Описание структуры"
    }
}

myStruct().getDescription() // "Описание структуры"

extension TextRepresentable {
    func about() -> String {
        return "Данный тип поддерживает протокол TextRepresentable"
    }
}

// Тип Int уже подписан на протокол TextRepresentable
5.about()
