//https://programmers.co.kr/learn/courses/30/lessons/92342

import Foundation

func ryan_winning_case(
    ryanCombos: Set<Int>,
    apeach: [Int], limit: Int
) -> (difference: Int, ryan: [Int])? {
    var ryan = Array(repeating: Int.zero, count: 11)
    
    ryanCombos.forEach { ryan[$0] = apeach[$0] + 1 }
    let miniumRequirement = ryan.sum()
    let ryanScore = ryanCombos.sum()
    let apeachScore = apeach.enumerated().reduce(Int.zero) {
        $0 + ($1.element != .zero && !ryanCombos.contains($1.offset) ? $1.offset : .zero)
    }
    
    guard miniumRequirement <= limit,
          ryanScore > apeachScore
    else { return nil }
    
    ryan[.zero] = limit - miniumRequirement
    return (ryanScore - apeachScore, ryan)
}

func betterAnswer(
    candidate1: (difference: Int, ryan: [Int]),
    candidate2: (difference: Int, ryan: [Int])
) -> (difference: Int, ryan: [Int]) {

    guard candidate1.difference == candidate2.difference
    else { return (candidate1.difference > candidate2.difference) ? candidate1 : candidate2 }
    
    for (element1, element2) in zip(candidate1.ryan, candidate2.ryan) {
        guard element1 != element2
        else { continue }
        
        return (element1 > element2) ? candidate1 : candidate2
    }
    return candidate1
}

func dfs(
    turns: Int,
    limit: Int,
    start: Int,
    ryanCombos: Set<Int>,
    apeach: [Int]
) -> (difference: Int, ryan: [Int])? {
    
    guard turns != .zero
    else { return ryan_winning_case(ryanCombos: ryanCombos, apeach: apeach, limit: limit) }
    
    var ryan = (difference: Int.zero, ryan: [-1])
    
    for number in start..<11 {
        var ryanCombo = ryanCombos
        ryanCombo.insert(number)
        
        guard let candidate = dfs(
            turns: turns - 1,
            limit: limit,
            start: number + 1,
            ryanCombos: ryanCombo,
            apeach: apeach
        )
        else { continue }
        
        ryan = betterAnswer(candidate1: ryan, candidate2: candidate)
    }
    
    return ryan
}

func solution(_ n:Int, _ info:[Int]) -> [Int] {
    
    let apeach: [Int] = info.reversed()
    var ryan = (difference: Int.zero, ryan: [-1])
    
    for counts in 1...n {
        guard let candidate = dfs(
            turns: counts,
            limit: n,
            start: 1,
            ryanCombos: [],
            apeach: apeach
        )
        else { continue }
        
        ryan = betterAnswer(candidate1: ryan, candidate2: candidate)
    }
    
    return ryan.ryan.reversed()
}

extension Collection where Element == Int {
    
    func sum() -> Int {
        self.reduce(.zero, +)
    }
}
