// https://programmers.co.kr/learn/courses/30/lessons/42748?language=swift

import Foundation

private let start = 0
private let end = 1
private let index = 2

func solution(_ array:[Int], _ commands:[[Int]]) -> [Int] {
    commands.map { array[$0[start]-1..<$0[end]].sorted()[$0[index] - 1] }
}