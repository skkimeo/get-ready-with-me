// https://programmers.co.kr/learn/courses/30/lessons/42746?language=swift

import Foundation

func solution(_ numbers:[Int]) -> String {
    let result = numbers.sorted {
        let left = String($0)
        let right = String($1)
        
        return Int(left + right)! > Int(right + left)!
    }
    
    guard Set(result) != [Int.zero]
    else { return String(Int.zero) }
    
    return result.reduce("") { $0 + String($1) }
}
