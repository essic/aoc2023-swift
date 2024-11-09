// The Swift Programming Language
// https://docs.swift.org/swift-book

import Algorithms
import Foundation

extension String {
    func cleanSplit(separator sep: String) -> [String] {
        return
            self
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .split(separator: sep)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .map { String($0) }
    }
}

/// A description
enum Cubes {
    case red(Int)
    case green(Int)
    case blue(Int)

    static func mk(value num: Int, color data: String) -> Cubes {
        switch data {
        case "red":
            return Cubes.red(num)
        case "green":
            return Cubes.green(num)
        case "blue":
            return Cubes.blue(num)
        default:
            fatalError("This should not be hapening !")
        }
    }

    func getValue() -> Int {
        switch self {
            case .red(let v) : return v
            case .blue(let v) : return v
            case .green(let v ): return v
        }
    }

}

extension [Cubes] {
    func getRed() -> Cubes {
        let val = self.map {
            if case .red(let num) = $0 {
                return num
            } else {
                return 0
            }
        }.reduce(0) {
            $0 + $1
        }
        return .red(val)
    }
    func getGreen() -> Cubes {
        let val = self.map {
            if case .green(let num) = $0 {
                return num
            } else {
                return 0
            }
        }.reduce(0) {
            $0 + $1
        }
        return .green(val)
    }
    func getBlue() -> Cubes {
        let val = self.map {
            if case .blue(let num) = $0 {
                return num
            } else {
                return 0
            }
        }.reduce(0) {
            $0 + $1
        }
        return .blue(val)
    }
}

extension Cubes: Comparable {
    func hasMoreThan0() -> Bool {
        switch self {
        case .red(0): false
        case .blue(0): false
        case .green(0): false
        default: true
        }
    }
}

struct GameSet {
    var content: [Cubes]
    static private let separator = ","

    init(_ cubes: Cubes...) {
        content = cubes
    }

    init(_ data: String) {
        content = []
        for rawCube in data.cleanSplit(separator: GameSet.separator) {
            let num = Int(
                rawCube.filter {
                    $0.isNumber
                })!

            let value = rawCube.filter {
                $0.isLetter
            }
            content.append(Cubes.mk(value: num, color: value))
        }
    }

    func getPower() -> Int {
        content.map { $0.getValue()}.reduce(1) {
            $0 * $1
        }
    }

    func isPossible(bag b: [Cubes]) -> Bool {

        let redFromBag = b.getRed()
        let redFromSet = content.getRed()
        let blueFromBag = b.getBlue()
        let blueFromSet = content.getBlue()
        let greenFromBag = b.getGreen()
        let greenFromSet = content.getGreen()
        return redFromBag >= redFromSet
            && greenFromBag >= greenFromSet
            && blueFromBag >= blueFromSet
    }
}

struct Game {
    private static let separatorToken = ":"
    private static let separatorToken2 = ";"
    let id: Int
    var sets: [GameSet] = []

    init(_ data: String) {
        let gameParts = data.cleanSplit(separator: Game.separatorToken)
        self.id = Int(gameParts.first!.filter { $0.isNumber })!
        let rawSets = gameParts[1]
        for rawSet in rawSets.cleanSplit(separator: Game.separatorToken2) {
            sets.append(GameSet(String(rawSet)))
        }
    }

    func isPossible(bag b: [Cubes]) -> Bool {
        sets.map {
            $0.isPossible(bag: b)
        }.reduce(true) {
            $0 && $1
        }
    }

    func idealSet() -> GameSet {
        let idealRed =
            sets.map{ $0.content.getRed()}.max()!

        let idealGreen =
            sets.map { $0.content.getGreen()}.max()!
        
        let ideadBlue =
            sets.map { $0.content.getBlue()}.max()!

        return GameSet(ideadBlue, idealGreen, idealRed)
    }
}

func day2Part1(_ data: String) -> Int {
    let bag: [Cubes] = [.red(12), .green(13), .blue(14)]
    var games: [Game] = []
    data.enumerateLines { line, stop in
        games.append(Game(line))
    }
    let possibleGames =
        games.filter {
            $0.isPossible(bag: bag)
        }

    return possibleGames.map { $0.id }.reduce(0) { $0 + $1 }
}

func day2Part2(_ data: String) -> Int {
    var games: [Game] = []
    data.enumerateLines { line, stop in
        games.append(Game(line))
    }
    let result = games.map { $0.idealSet() }.map{ $0.getPower()}.reduce(0) {
        $0 + $1
    }
    return result
}

func day2(_ data: String) -> (part1: Int, part2: Int) {
    (day2Part1(data), day2Part2(data))
}