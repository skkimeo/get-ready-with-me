// https://programmers.co.kr/learn/courses/30/lessons/42747?language=swift#

import Foundation

func solution(_ citations:[Int]) -> Int {
    let numberOfPublications = citations.count
    var hIndex = Int.zero
    var citations = citations.sorted() 

    for citationCount in 0...citations.max()! {
        guard let index = citations.firstIndex { $0 >= citationCount },
        numberOfPublications - index >= citationCount
        else { continue }

        hIndex = citationCount
    }

    return hIndex
}

func solution(_ citations:[Int]) -> Int {
    let citations = citations.sorted(by: >)
    var result = 0
    
    for index in 0..<citations.count {
        guard index + 1 <= citations[index]
        else { break }
        
        result = index + 1
    }

    return result
}
