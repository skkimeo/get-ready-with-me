// https://programmers.co.kr/learn/courses/30/lessons/43163#

import Foundation

private var visited = Set<String>()
private var answer = Int.max

func solution(_ begin:String, _ target:String, _ words:[String]) -> Int {
    let answer = dfs(start: begin, target: target, words: words)
    return (answer == .max) ? .zero : answer
}

private func dfs(start: String, target: String, words: [String]) -> Int {
    guard start != target
    else { return visited.count }
    
    var answer = Int.max
    visited.insert(start)
    for word in words { 
        guard !visited.contains(word),
              transitionIsPossible(from: start, to: word)
        else { continue }

        answer = min(answer, dfs(start: word, target: target, words: words))
    }
    visited.remove(start)
    
    return answer
}

private func transitionIsPossible(from start: String, to end: String) -> Bool {
    zip(start, end).filter { $0.0 != $0.1 }.count == 1
}
