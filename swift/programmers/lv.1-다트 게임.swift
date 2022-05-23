// https://programmers.co.kr/learn/courses/30/lessons/17682?language=swift

import Foundation

let exponents = ["S": 1, "D": 2, "T": 3]
let bonus = ["*": 2, "#": -1]

func solution(_ dartResult:String) -> Int {
    var numbers = [0] + dartResult
        .components(separatedBy: ["S", "D", "T", "*", "#"])
        .compactMap { Int($0) }
    
    let instructions = dartResult
        .components(separatedBy: .decimalDigits)
        .filter { !$0.isEmpty }
    
    for (index, instruction) in instructions.enumerated() {
        let index = index + 1
        instruction.forEach {
            let instructionString = String($0)
            if exponents.keys.contains(instructionString) {
                numbers[index] = Int(pow(
                    Double(numbers[index]),
                    Double(exponents[instructionString, default: .zero])
                ))
            }
            
            if bonus.keys.contains(instructionString) {
                numbers[index] *= bonus[instructionString, default: 1]
                if instructionString == "*" {
                    numbers[index - 1] *= bonus[instructionString, default: 1]
                }
            }
        }
    }
    
    return numbers.reduce(Int.zero, +)
}
