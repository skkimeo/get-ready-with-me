// https://programmers.co.kr/learn/courses/30/lessons/17680#

import Foundation

private enum Time {
    static let hit = 1
    static let miss = 5
}

func solution(_ cacheSize:Int, _ cities:[String]) -> Int {
    var cache = [String]()
    
    return cities.reduce(Int.zero) { partialResult, city in
        let city = city.lowercased()
                                    
        guard !cache.contains(city)
        else {
            cache.removeAll { $0 == city }
            cache.append(city)
            return partialResult + Time.hit 
        }
        
        guard cacheSize > .zero
        else { return partialResult + Time.miss }
        
        if cache.count == cacheSize {
            cache.removeFirst()
        }
        cache.append(city.lowercased())
        
        return partialResult + Time.miss
    }
}
