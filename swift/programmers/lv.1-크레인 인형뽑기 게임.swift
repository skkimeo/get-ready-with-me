//https://programmers.co.kr/learn/courses/30/lessons/64061

import Foundation

func parseBoard(_ board: [[Int]]) -> [[Int]] {
    var columns: [[Int]] = Array(repeating: [], count: board.count)
    
    for row in board {
        for (column, doll) in row.enumerated() {
            guard doll != .zero
            else { continue }
            
            columns[column].append(doll)
        }
    }
    
    return columns
}

func solution(_ board:[[Int]], _ moves:[Int]) -> Int {
    var columns = parseBoard(board.reversed())
    var dolls = [Int]()
    var answer = Int.zero
    
    moves.forEach {
        let column = $0 - 1
        guard !columns[column].isEmpty
        else { return }
        
        let newDoll = columns[column].removeLast()
        
        guard dolls.last == newDoll
        else { return dolls.append(newDoll) }
        
        dolls.removeLast()
        answer += 2
    }
    
    return answer
}
