// https://programmers.co.kr/learn/courses/30/lessons/17681?language=swift

import Foundation

func solution(_ n:Int, _ arr1:[Int], _ arr2:[Int]) -> [String] {
    var answer: [String] = []

    for (wall1, wall2) in zip(arr1, arr2) {
        var combinedWall = wall1 | wall2
        var wallString = ""

        for _ in 1...n {
            wallString.append((combinedWall % 2 == .zero) ? " " : "#")
            combinedWall >>= 1
        }
        answer.append(String(wallString.reversed()))
    }
    return answer
}

/// 더 나은 방식
func swiftySolution(_ n:Int, _ arr1:[Int], _ arr2:[Int]) -> [String] {
    var answer: [String] = []
    
    for (wall1, wall2) in zip(arr1, arr2) {
        let binary = String(wall1 | wall2, radix: 2)
        let paddedBinary = String(repeating: "0", count: n - binary.count) + binary
        let combinedWall = paddedBinary.reduce("") { $0 + ($1 == "0" ? " " : "#") }
        answer.append(combinedWall)
    }
    return answer
}
