// https://programmers.co.kr/learn/courses/30/lessons/42587

import Foundation

func solution(_ priorities:[Int], _ location:Int) -> Int {
    var priorities = Array(priorities.enumerated())
    var order = Int.zero
    
    while !priorities.isEmpty {
        let file = priorities.removeFirst()
        
        guard !priorities.contains(where: { $0.element > file.element })
        else {
            priorities.append(file)
            continue
        }
        
        order += 1
        
        guard file.offset == location
        else { continue }
        
        break
    }
    
    return order
}
