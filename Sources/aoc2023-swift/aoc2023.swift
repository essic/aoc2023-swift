// The Swift Programming Language
// https://docs.swift.org/swift-book

import Algorithms
import Foundation

let alsoValidDigits = [
    "one": "1", "two": "2", "three": "3", "four": "4", "five": "5", "six": "6", "seven": "7",
    "eight": "8", "nine": "9",
]

func findAllOccurences(of str: String, with target: String) -> (digit: String, positions: [Int]) {
    var startSearchFrom = str.startIndex
    var results = [Int]()
    while startSearchFrom < str.endIndex {
        guard let result = str[startSearchFrom...].range(of: target) else {
            break
        }

        let indexOfOccurence = str.distance(from: str.startIndex, to: result.lowerBound)
        results.append(indexOfOccurence)
        startSearchFrom = result.upperBound
    }
    return (target, results)
}

func findAllDigitsOccurences(of str: String) -> [String] {
    let allDigits = chain(alsoValidDigits.keys, alsoValidDigits.values)
    let result =
        allDigits.flatMap {
            let localOccurences = findAllOccurences(of: str, with: $0)
            return localOccurences.positions.map {
                return ($0, localOccurences.digit)
            }
        }.sorted {
            $0.0 < $1.0
        }.map { $0.1 }
    return result
}

do {
    let data = try String(contentsOfFile: "day1-input.txt")
    var numbers = [Int]()
    data.enumerateLines { line, stop -> Void in
        let result = findAllDigitsOccurences(of: line)
        let digits = result.map {
            if let value = alsoValidDigits[$0] {
                return Int(value)!
            } else {
                return Int($0)!
            }
        }   

        if digits.count > 1 {
            numbers.append(10 * digits.first! + digits.last!)
        } else {
            numbers.append(10 * digits.first! + digits.first!)
        }
    }

    let sum = numbers.reduce(0) { x, y in
        x + y
    }
    print(sum)
} catch {
    print("Could not find file.")
}
