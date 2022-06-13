// https://programmers.co.kr/learn/courses/30/lessons/60057

import Foundation

func solution(_ s:String) -> Int {
    var answer = s.count
    let reversedS: [Character] = s.reversed()
    let string = reversedS.reduce("") { $0 + String($1) }
    
    for length in 1..<s.count {
        answer = min(answer, zipBySliceSize(length, string: string))
    }
    
    return answer
}

private func zipBySliceSize(_ sliceSize: Int, string: String) -> Int {
    var string = string
    var previousSlice = ""
    var counts = [Int]()
    
    while string.count >= sliceSize {
        let slice = String(string.suffix(sliceSize))
        string.removeLast(sliceSize)
        
        guard slice != previousSlice
        else { 
            counts.append(counts.removeLast() + 1)
            continue
        }
        counts.append(1)
        previousSlice = slice
    }

    return string.count + counts.count * sliceSize + counts.reduce(Int.zero) { 
        guard $1 != 1
        else { return $0 }
        
        return $0 + String($1).count
    }
}
