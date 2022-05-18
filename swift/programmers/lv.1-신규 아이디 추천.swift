// https://programmers.co.kr/learn/courses/30/lessons/72410?language=swift

import Foundation

let minus: Character = "-"
let underBar: Character = "_"
let period: Character = "."
let allowedSymbols = Set([minus, underBar, period])
let maxLength = 15

func solution(_ new_id:String) -> String {
    var newID = new_id.lowercased()
    
    newID = newID.filter { $0.isLetter || $0.isNumber || allowedSymbols.contains($0) }
    
    newID = newID.reduce(String.empty) { partialResult, character in
        guard character != period || partialResult.last != period
        else { return partialResult }
        
        return partialResult.appending(String(character))
    }
    
    newID.removePeriodsAtEachEnd()
    
    if newID.isEmpty {
        newID = "a"
    }
    
    if newID.count > maxLength {
        newID = String(newID.prefix(maxLength))
    }
    
    newID.removePeriodsAtEachEnd()
    
    while newID.count < 3 {
        guard let lastCharacter = newID.last
        else { return newID }
        
        newID.append(lastCharacter)
    }
    
    return newID
}

extension String {
    
    static let empty = ""
    
    mutating func removePeriodsAtEachEnd() {
        if self.first == period {
            self.removeFirst()
        }
        
        if self.last == period {
            self.removeLast()
        }
    }
}