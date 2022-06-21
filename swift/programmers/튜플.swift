// https://programmers.co.kr/learn/courses/30/lessons/64065

func solution(_ s:String) -> [Int] {
    backtrackTuple(from: parseString(s))
}

extension Array where Element == [Int] {
    func sortedByLength() -> [Element] { self.sorted { $0.count < $1.count } }
}

private func parseString(_ str: String) -> [[Int]] {
    str.components(separatedBy: ["{", "}"]).reduce([]) {
        let numbers = $1.components(separatedBy: [",", " "]).compactMap { Int($0) }
        
        guard !numbers.isEmpty
        else{ return $0 }
        
        return $0 + [numbers]
    }
}

private func backtrackTuple(from array: [[Int]]) -> [Int] {
    var array = array.sortedByLength()
    var tuple = [Int]()
    
    for subArray in array {
        guard let number = subArray.first(where: { !tuple.contains($0) })
        else { continue }
        
        tuple.append(number)
    }
    
    return tuple
}
