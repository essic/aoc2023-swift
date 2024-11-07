// The Swift Programming Language
// https://docs.swift.org/swift-book

import Algorithms
import Foundation

let fromWordToDigitStr = [
    "one": "1", "two": "2", "three": "3", "four": "4", "five": "5", "six": "6", "seven": "7",
    "eight": "8", "nine": "9",
]

let fromDigitStrToDigit = Dictionary.init(
    uniqueKeysWithValues: fromWordToDigitStr.values.map { ($0, Int($0)!) }
)

let allDigits = chain(fromWordToDigitStr.keys, fromWordToDigitStr.values)

func findAllOccurences(of str: String, with target: String) -> (occurence: String, positions: [Int])
{
    var startSearchFrom = str.startIndex
    var occurencePositions = [Int]()
    while startSearchFrom < str.endIndex {
        guard let occurenceRange = str[startSearchFrom...].range(of: target) else {
            break
        }

        let indexOfOccurence = str.distance(from: str.startIndex, to: occurenceRange.lowerBound)
        occurencePositions.append(indexOfOccurence)
        startSearchFrom = occurenceRange.upperBound
    }
    return (target, occurencePositions)
}

//Why mainActor ?
@MainActor func allDigitOccurencesSortedByAppearingPosition(of str: String) -> [String] {
    return allDigits.flatMap {
        let localOccurences = findAllOccurences(of: str, with: $0)
        return localOccurences.positions.map {
            return ($0, localOccurences.occurence)
        }
    }.sorted {
        $0.0 < $1.0
    }.map { $0.1 }
}

let data = try String(contentsOfFile: "day1-input.txt")
var total = 0
data.enumerateLines { line, _ -> Void in
    let digits = allDigitOccurencesSortedByAppearingPosition(of: line).map {
        if let digitStr = fromWordToDigitStr[$0] {
            return fromDigitStrToDigit[digitStr]!
        } else {
            return fromDigitStrToDigit[$0]!
        }
    }
    total += 10 * digits.first! + (digits.count > 1 ? digits.last! : digits.first!)
}

print(total)
