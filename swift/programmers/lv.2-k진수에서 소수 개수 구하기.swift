// https://programmers.co.kr/learn/courses/30/lessons/92335

import Foundation

func solution(_ n:Int, _ k:Int) -> Int {
    String(n, radix: k)
        .split(separator: "0")
        .filter { Int($0)?.isPrimeNumber  == true }
        .count
}

extension Int {
    
    var isPrimeNumber: Bool {
        guard self > 3
        else { return (self < 2) ? false : true }
        
        let root = Int(sqrt(Double(self)))
        for primeFactor in 2...root {
            guard self % primeFactor == .zero
            else { continue }
            
            return false
        }
        return true
    }
}
