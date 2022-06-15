import Foundation

private enum Operator: CaseIterable {
    case plus
    case minus
    
    func operate(operand: Int) -> Int {
        switch self {
            case .plus:
                return operand
            case .minus:
                return -operand
        }
    }
}

func solution(_ numbers:[Int], _ target:Int) -> Int {
    dfs(throughNumbers: numbers, target: target, result: .zero)
        .filter { $0 == target }
        .count
}

private func dfs(throughNumbers numbers: [Int], target: Int, result: Int) -> [Int] {
    guard !numbers.isEmpty
    else { return [result] }
    
    var answer = [Int]()
    var numbers = numbers
    let operand = numbers.removeLast()
    
    for symbol in Operator.allCases {
        let newResult = symbol.operate(operand: operand) + result
        answer += dfs(throughNumbers: numbers, target: target, result: newResult)
    }
    
    return answer
}
