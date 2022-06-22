// https://programmers.co.kr/learn/courses/30/lessons/42890
/**
- 최소성 만족은 기존 후보키 중 교집합이 있는 후보키가 있는지가 아니라 "부분집합"인 후보키가 있는지 확인해야 함
**/

import Foundation

func solution(_ relation:[[String]]) -> Int {
    findCandidateKeys(inRelation: relation).count
}

private func findCandidateKeys(inRelation relation: [[String]]) -> Set<[Int]> {
    var keys = Set<[Int]>()
    
    for count in 1...relation[0].count {
        combinations(inNumbers: relation[0].count, start: 0, count: count).forEach { combo in
            guard isUniqueKey(combo, relation: relation)
            else { return }
            
            for key in keys {
                guard key.filter({ combo.contains($0) }) != key
                else { return }
            }
            keys.insert(combo)
        }
    }
    
    return keys
}

private func combinations(inNumbers numbers: Int, start: Int, count: Int) -> [[Int]] {
    guard count != .zero
    else { return [[]] }
    
    var answer = [[Int]]()
    
    for number in start..<numbers {
        combinations(inNumbers: numbers, start: number + 1, count: count - 1).forEach {
            answer.append([number] + $0)
        }
    }
    return answer
}

private func isUniqueKey(_ keys: [Int], relation: [[String]]) -> Bool {
    var students = Set<[String]>()
    
    for student in relation {
        students.insert(keys.map { student[$0] })
    }

    return relation.count == students.count
}
