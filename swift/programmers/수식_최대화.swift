// https://programmers.co.kr/learn/courses/30/lessons/67257

import Foundation

private enum Operand {
    static let minus = "-"
    static let plus = "+"
    static let times = "*"
}

private var operands: Set<String>!

func solution(_ expression:String) -> Int64 {
    var answer = Int.zero
    
    operands = Set(expression.components(separatedBy: .decimalDigits)).filter { !$0.isEmpty }
    let expression = parseExpression(expression)
    
    combinations(from: operands).forEach {
        answer = max(answer, calculateExpression(expression, withOperandOrder: $0))
    }
    
    return Int64(answer)
}

private func parseExpression(_ expression: String) -> [String] {
    expression.reduce([]) { partialResult, character in
        guard character.isNumber,
              !partialResult.isEmpty,
              !operands.contains(partialResult.last!)
        else { return partialResult + [String(character)] }
        
        return partialResult.dropLast() + [partialResult.last! + String(character)]
    }
}

private func combinations(from array: Set<String>) -> [[String]] {
    guard !array.isEmpty
    else { return [[]] }
    
    var combos = [[String]]()
    var candiates = array
    
    array.forEach { operand in
        candiates.remove(operand)
        combinations(from: candiates).forEach { combos.append([operand] + $0) }
        candiates.insert(operand)
    }
    return combos
}

private func calculateExpression(
    _ expression: [String],
    withOperandOrder operandOrder: [String]
) -> Int {
    
    var left = [String]()
    var right: [String] = expression.reversed()
    
    for operand in operandOrder {
        while !right.isEmpty {
            let element = right.removeLast()
            
            guard element == operand
            else {
                left.append(element)
                continue
            }
            
            let firstNumber = left.removeLast()
            let secondNumber = right.removeLast()
            
            left.append(calculate(leftHand: firstNumber, rightHand: secondNumber, operand: operand))
        }
        right = left.reversed()
        left = []
    }
    return abs(Int(right.first!)!)
}

func calculate(leftHand left: String, rightHand right: String, operand: String) -> String {
    guard let left = Int(left),
          let right = Int(right)
    else { return "" }
    
    var result = Int.zero
    
    if operand == Operand.minus { result = left - right }
    if operand == Operand.plus { result = left + right }
    if operand == Operand.times { result = left * right }

    return String(result)
}