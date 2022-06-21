//https://programmers.co.kr/learn/courses/30/lessons/17677?language=swift
import Foundation

func solution(_ str1:String, _ str2:String) -> Int {
    Int(str1.multiSet().jaccardSimilarity(between: str2.multiSet()) * 65536)
}

extension String {
    func multiSet() -> [String] {
        var multiSet = [String]()
        let array = self.map { $0.lowercased() }
        
        for index in Int.zero..<array.count - 1 {
            let word = array[index..<index + 2]
            
            guard word.isLetters
            else { continue }
            
            multiSet.append(word.joined())
        }
        
        return multiSet
    }
}

extension ArraySlice where Element == String {
    var isLetters: Bool {
        for letter in self {
            guard !Character(letter).isLetter
            else { continue }
            
            return false
        }
        return true
    }
}

extension Array where Element == String {
    func jaccardSimilarity(between b: [String]) -> Double {
        guard !self.isEmpty || !b.isEmpty
        else { return 1 }
        
        return Double(self.intersection(b).count) / Double(self.union(b).count)
        
    }
    
    func union(_ b: [String]) -> [String] {
        var a = self
        var b = b
        var union = [String]()
        
        for element in Set(a).union(Set(b)) {
            let count = Swift.max(a.removeAll(element: element), b.removeAll(element: element))
            union += Array(repeating: element, count: count)
        }
        return union
    }
    
    func intersection(_ b: [String]) -> [String] {
        var a = self
        var b = b
        var intersection = [String]()

        for element in Set(a).union(Set(b)) {
            let count = Swift.min(a.removeAll(element: element), b.removeAll(element: element))
            intersection += Array(repeating: element, count: count)
        }
        return intersection
    }
    
    mutating func removeAll(element: String) -> Int {
        var count = Int.zero
        self.removeAll {
            guard $0 == element
            else { return false }
            count += 1
            return true
        }
        return count
    }
}
