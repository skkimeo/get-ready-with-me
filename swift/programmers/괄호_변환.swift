// https://programmers.co.kr/learn/courses/30/lessons/60058?language=swift

import Foundation

private enum Bracket {
    static let left = "("
    static let right = ")"
}

func solution(_ p:String) -> String {
    guard !p.isEmpty,
          !p.isCorrect
    else { return p }
    
    let input = p
    let index = input
            .enumerated()
            .first { String(input.prefix($0.offset + 1)).isBalanced }!
            .offset
    
    var u = String(input.prefix(index + 1))
    let v = String(input.dropFirst(index + 1))

    guard !u.isCorrect
    else { return u + solution(v) }
    
    u.removeFirst()
    u.removeLast()
    
    return Bracket.left + solution(v) + Bracket.right + u.reduce("") {
        $0 + ((String($1) == Bracket.left) ? Bracket.right : Bracket.left)
    }
}

extension String {
    var isBalanced: Bool {
        self.filter { String($0) == Bracket.left }.count == self.filter { String($0) == Bracket.right }.count
    }
    
    var isCorrect: Bool {
        guard self.isBalanced
        else { return false }
        
        var stack = [String]()
        
        for bracket in self {
            let bracket = String(bracket)
            guard bracket == Bracket.right
            else {
                stack.append(bracket)
                continue
            }
            
            guard stack.popLast() == Bracket.left
            else { return false }
        }
        return true
    }
}
