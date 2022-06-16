// https://programmers.co.kr/learn/courses/30/lessons/81302?language=swift

import Foundation

private let person = "P"
private let table = "O"
private let partition = "X"
private let size = 5

func solution(_ places:[[String]]) -> [Int] {
    var answer = [Int]()
    
    for place in places {
        let place = place.map { $0.map { String($0) } }
        answer.append(checkIfRuleIsViolated(in: place) == true ? 0 : 1)
    }
    
    return answer
}

private func checkIfRuleIsViolated(in place: [[String]]) -> Bool {
    var people: [(x: Int, y: Int)] = filterPeople(in: place)

    while !people.isEmpty {
        let person = people.removeLast()
        for otherPerson in people {
            let distance = manhattanDistance(a: person, b: otherPerson)

            guard distance <= 2
            else { continue }
            
            guard distance == 2
            else { return true }
            
            guard checkForPartitionBetween(a: person, b:otherPerson, place: place) == false
            else{ continue }

            return true
        }
    }
    return false 
}

private func filterPeople(in place: [[String]]) -> [(Int, Int)] {
    var people = [(Int, Int)]()
    
    for row in Int.zero..<size {
        for column in Int.zero..<size {
            guard place[row][column] == person
            else { continue }
            
            people.append((row, column))
        }
    }
    
    return people
}

private func manhattanDistance(a: (x: Int, y:Int), b: (x: Int, y: Int)) -> Int {
    return abs(a.x - b.x) + abs(a.y - b.y)
}

private func checkForPartitionBetween(
    a: (x: Int, y:Int),
    b: (x: Int, y: Int),
    place: [[String]]
) -> Bool {
    guard a.x != b.x
    else { return place[a.x][(a.y + b.y) / 2] == partition }
    
    guard a.y != b.y
    else { return place[(a.x + b.x) / 2][a.y] == partition }
    
    return place[a.x][b.y] == partition && place[b.x][a.y] == partition
}
