//https://programmers.co.kr/learn/courses/30/lessons/81301?language=swift

import Foundation

func solution(_ s:String) -> Int {
    let numbers = [
        "zero": "0",
        "one": "1",
        "two": "2",
        "three": "3",
        "four": "4",
        "five": "5",
        "six": "6",
        "seven": "7",
        "eight": "8",
        "nine": "9"
    ]
    var answer = s
    
    numbers.forEach { answer = answer.replacingOccurrences(of: $0, with: $1) }
    
    return Int(answer) ?? .zero
}
