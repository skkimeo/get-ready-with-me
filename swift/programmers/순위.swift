// https://programmers.co.kr/learn/courses/30/lessons/49191#

import Foundation

private let win = 0
private let lose = 1

private var board = [(win: Set<Int>, lose: Set<Int>)]()
private var visited = [Bool]()

func solution(_ n:Int, _ results:[[Int]]) -> Int {
    board = parseResults(results, n: n)
    for player in 1...n {
        visited = Array(repeating: false, count: n + 1)
        dfs(player: player)
    }
    return definitePlayers(total: n)
}

private func definitePlayers(total: Int) -> Int {
    var count = Int.zero
    for player in board.dropFirst() {
        guard player.win.count + player.lose.count == total - 1
        else{ continue }
        
        count += 1
    }
    return count
}

private func dfs(player: Int) {
    var answer = Array(board[player].win)
    visited[player] = true 
    
    while !answer.isEmpty {
        let loser = answer.removeLast()
        board[player].win = board[player].win.union(board[loser].win)
        board[loser].lose = board[loser].lose.union(board[player].lose)
        
        guard !visited[loser]
        else { continue }
        
        visited[loser] = true
        
        for newLoser in board[loser].win {
            answer.append(newLoser)
        }
    }
}

private func parseResults(_ results: [[Int]], n: Int) -> [(win: Set<Int>, lose: Set<Int>)] {
    var answer = Array(repeating: (win: Set<Int>(), lose: Set<Int>()), count: n + 1)
    
    for result in results {
        let winner = result[win]
        let loser = result[lose]
        
        answer[winner].win.insert(loser)
        answer[loser].lose.insert(winner)
    }
    return answer 
}
