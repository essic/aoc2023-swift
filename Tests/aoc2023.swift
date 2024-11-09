import Testing
@testable import aoc2023


 @Test("Test for day 1") func executeDay1() {
     let data = """
     two1nine
     eightwothree
     abcone2threexyz
     xtwone3four
     4nineeightseven2
     zoneight234
     7pqrstsixteen
     """

     let result = day1(data)

     #expect(result == 281)
 }

 @Test("Test for day 2 / part 1") func executeDay2Part1() {
     let data = """
     Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
     Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
     Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
     Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
     Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
     """

     let result = day2Part1(data)

     #expect(result == 8)
 }

 @Test("Test for day 2 / part 1") func executeDay2() {
     let data = """
     Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
     Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
     Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
     Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
     Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
     """

     let result = day2Part2(data)

     #expect(result == 2286)
 }
