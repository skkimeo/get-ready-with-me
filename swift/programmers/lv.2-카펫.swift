// https://programmers.co.kr/learn/courses/30/lessons/42842?language=swift

import Foundation

func solution(_ brown:Int, _ yellow:Int) -> [Int] {
    var answer = [Int]()
    let total = brown + yellow 
    
    for row in 3...brown {
        guard total % row == Int.zero
        else { continue }

        let column = total / row 
        
        let yellowWidth = column - 2
        let yellowHeight = row - 2
        
        guard yellowWidth * yellowHeight == yellow
        else { continue }

        answer = [column, row]
        break
    }
    
    return answer
}