// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

print("Which day ? : ", terminator: "")
guard let input = readLine(), let day = Int(input), day <= 31 && day >= 1 else {
  print("Input invalid !")
  exit(1)
}

let inputFile = "day\(day)-input.txt"
let content = try String(contentsOfFile: inputFile, encoding: .utf8)
print("Day \(day) : ", terminator: "")

switch day {
case 1:
  print(day1(content))
case 2:
  print(day2(content))
default:
  print("Not YET IMPLEMENTED")
}
