// https://programmers.co.kr/learn/courses/30/lessons/43162#

import Foundation

private var parent = [Int]()

func solution(_ n:Int, _ computers:[[Int]]) -> Int {
    parent = Array(0..<n)
    parseGraph(computers, size: n).forEach { union(a: $0.a, b: $0.b) }
    (0..<n).forEach { parent[$0] = findParent(of: $0) }
    
    return Set(parent).count
}

private func parseGraph(_ graph: [[Int]], size: Int) -> [(a: Int, b: Int)] {
    var nodes = [(Int, Int)]()
    for row in 0..<size {
        for column in row + 1..<size {
            guard graph[row][column] == 1
            else { continue }
            
            nodes.append((row, column))
        }
    }
    
    return nodes
}

private func union(a: Int, b: Int) {
    let a = findParent(of: a)
    let b = findParent(of: b)
    
    guard a < b 
    else { return parent[a] = b }
    
    parent[b] = a
}

private func findParent(of node: Int) -> Int {
    guard node != parent[node]
    else { return node }
    
    return findParent(of: parent[node])
}
