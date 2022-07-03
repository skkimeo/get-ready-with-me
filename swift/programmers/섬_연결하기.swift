// https://programmers.co.kr/learn/courses/30/lessons/42861

import Foundation

private var parents = [Int]()

func solution(_ n:Int, _ costs:[[Int]]) -> Int {
    parents = Array(0...n)
    var cost = Int.zero
    
    for data in costs.sorted(by: { $0[2] < $1[2] }) {
        let a = data[0]
        let b = data[1]
        
        guard findParent(of: a) != findParent(of: b)
        else { continue }
        
        union(a, b)
        cost += data[2]
    }
    
    return cost
}

private func findParent(of x: Int) -> Int {
    guard x != parents[x]
    else { return x }
    
    parents[x] = findParent(of: parents[x])
    return parents[x]
}

private func union(_ a: Int, _ b: Int) {
    let a = findParent(of: a)
    let b = findParent(of: b)
    
    if a < b {
        parents[b] = a
    } else {
        parents[a] = b
    }
}
