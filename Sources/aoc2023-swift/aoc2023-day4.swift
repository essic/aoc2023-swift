private struct Card {
  let id: Int
  let winningNumbers: [Int]
  let gamerNumbers: [Int]

  func getNbOfMatches() -> Int {
    return winningNumbers.filter { gamerNumbers.contains($0) }.count
  }

  //TODO: Find the right algorithm !
  func computeWorth() -> Int {
    var worth = 0
    for w in winningNumbers {
      let toto = gamerNumbers.filter {
        $0 == w
      }

      worth = toto.reduce(worth) { x, _ in
        if x == 0 {
          return 1
        } else {
          return x * 2
        }
      }
    }
    return worth
  }

}

private func getCard(_ rawScratchCard: String) -> Card {
  let gameParts = rawScratchCard.cleanSplit(separator: ":")
  let cardId = Int(String(gameParts[0].cleanSplit(separator: " ").last!))!
  let toto = gameParts[1].cleanSplit(separator: " | ")
  let wNumbers = toto[0].cleanSplit(separator: " ").map {
    Int($0.trimmingCharacters(in: .whitespacesAndNewlines))!
  }
  let gNumbers = toto[1].cleanSplit(separator: " ").map {
    Int($0.trimmingCharacters(in: .whitespacesAndNewlines))!
  }
  return Card(id: cardId, winningNumbers: wNumbers, gamerNumbers: gNumbers)
}

func day4Part1(_ content: String) -> Int {

  var totalWorth = 0
  let lines = content.components(separatedBy: "\n")
  for line in lines {
    if line.isEmpty {
      continue
    }
    let card = getCard(line)
    totalWorth += card.computeWorth()
  }
  return totalWorth
}

func day4Part2(_ content: String) -> Int {
  let cards = content.components(separatedBy: "\n").filter {
    $0.trimmingCharacters(in: .whitespacesAndNewlines).count > 0
  }.map { getCard($0) }

  var originals = [Int: [Int]]()
  var copies = [Int]()
  var winners = [Int]()
  for (index, card) in cards.enumerated() {
    let nextIndex = index + 1
    let nb = card.getNbOfMatches()
    let toIndex = nextIndex + nb
    let remainder = cards[nextIndex..<toIndex]
    let copiesForCard = remainder.map { $0.id }
    originals[card.id] = copiesForCard
    copies.append(contentsOf: copiesForCard)
    let nbInstance = copies.count { $0 == card.id }
    for _ in 0..<nbInstance {
      copies.append(contentsOf: copiesForCard)
    }

  }
  winners.append(contentsOf: copies)
  winners.append(contentsOf: originals.keys)

  let toto = winners.grouped { $0 }.map { $0.value.count }

  return toto.reduce(0) { $0 + $1 }
}

func day4(_ data: String) -> (Int, Int) {
  return (day4Part1(data), day4Part2(data))
}
