//https://programmers.co.kr/learn/courses/30/lessons/42860/solution_groups?language=swift&type=my

/**
- 그리디 카테에 있었는데 아무리 해도 그리디는 아닌 것 같아서 결국 완탐으로 풀음 그리디 절대 안된다고...흑흑
- 약간 생각하기 싫으니까 나중에 다시 풀어보고 생각 과정 정리해보기...
**/

import Foundation

private let distance: [Character: Int] = {
    let alphabets = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    let length = alphabets.count
    var distance = [Character: Int]()

    for (index, alphabet) in alphabets.enumerated() {
        distance[alphabet] = minimumDistance(a: .zero, b: index, length: length)
    }
    return distance
}()

func solution(_ name:String) -> Int {
    let moveCount = calculateMoves(
        from: name.enumerated().filter { $0.element != "A" },
        order: [0],
        length: name.count
    )
    let transCount = name.reduce(Int.zero) {
        return $0 + distance[$1, default: .zero]
    }
    return moveCount + transCount
}

private func calculateMoves(from array: [(Int, Character)], order: [Int], length: Int) -> Int {
    guard !array.isEmpty
    else {
        var answer = Int.zero
        for index in 0..<order.count - 1{
            answer += minimumDistance(a: order[index], b: order[index + 1], length: length)
        }
        return answer
    }
    
    return min(
        calculateMoves(from: Array(array.dropFirst()), order: order + [array.first!.0], length: length),
        calculateMoves(from: Array(array.dropLast()), order: order + [array.last!.0], length: length)
    )
    
}

func minimumDistance(a: Int, b: Int, length: Int) -> Int {
    let distance = abs(a.distance(to: b))
    
    return min(distance, length - distance)
}
