// https://programmers.co.kr/learn/courses/30/lessons/42839#

import Foundation

func solution(_ numbers:String) -> Int {
    var primeNumbers = Set<Int>()

    possibleNumbers(from: numbers.map { String($0) })
    .compactMap { Int($0.joined()) }
    .forEach { 
        guard $0.isPrime == true
        else { return }

        primeNumbers.insert($0)
    }

    return primeNumbers.count
}

private func possibleNumbers(from numbers: [String]) -> [[String]] {
    guard numbers.count > 1
    else { return [numbers] + [[]] }

    var numbers = numbers
    var answer: [[String]] = []

    for (index, number) in numbers.enumerated() {
        answer.append([numbers.remove(at: index)])
        possibleNumbers(from: numbers).forEach { answer.append([number] + $0) }
        numbers.insert(number, at: index)
    }
    return answer
}

extension Int {
    var isPrime: Bool {
        guard self > 1
        else { return false }

        guard self > 3
        else { return true }

        for divider in 2...self.squareRoot {
            guard self % divider == .zero
            else { continue }

            return false
        }
        return true
    }

    var squareRoot: Int { Int(Double(self).squareRoot()) }
}
