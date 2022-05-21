// https://programmers.co.kr/learn/courses/30/lessons/67256?language=swift

import Foundation

let leftOnly: Set<Int> = [1, 4, 7]
let rightOnly: Set<Int> = [3, 6, 9]
let positions = [
    (3, 1),
    (0, 0),
    (0, 1),
    (0, 2),
    (1, 0),
    (1, 1),
    (1, 2),
    (2, 0),
    (2, 1),
    (2, 2),
    (3, 1)
]
let left = "L"
let right = "R"
let leftHanded = "left"

func distanceBetween(a: (x: Int, y: Int), b: (x: Int, y: Int)) -> Int {
    abs(a.x - b.x) + abs(a.y - b.y)
}

func solution(_ numbers:[Int], _ hand:String) -> String {
    var answer = ""
    var leftPosition = (3, 0)
    var rightPosition = (3, 2)
    
    numbers.forEach {
        let moveTo = positions[$0]
        
        if leftOnly.contains($0) {
            leftPosition = moveTo
            answer.append(left)
            return
        }
        
        if rightOnly.contains($0) {
            rightPosition = moveTo
            answer.append(right)
            return
        }
        
        let leftDistance = distanceBetween(a: leftPosition, b: moveTo)
        let rightDistance = distanceBetween(a: rightPosition, b: moveTo)
        
        if leftDistance < rightDistance {
            leftPosition = moveTo
            answer.append(left)
            return
        }
        
        if leftDistance > rightDistance {
            rightPosition = moveTo
            answer.append(right)
            return
        }
        
        if hand == leftHanded {
            leftPosition = moveTo
        } else {
            rightPosition = moveTo
        }
        answer.append(hand == leftHanded ? left : right)
    }
    
    return answer
}
