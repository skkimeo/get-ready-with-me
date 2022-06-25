// https://programmers.co.kr/learn/courses/30/lessons/42583?language=swift

import Foundation

func solution(_ bridge_length:Int, _ weight:Int, _ truck_weights:[Int]) -> Int {
    let empty = Int.zero
    var bridge = Array(repeating: empty, count: bridge_length)
    var trucks: [Int] = truck_weights.reversed()
    var time = Int.zero 
    var weightOnBridge = Int.zero
    
    while !bridge.isEmpty {
        time += 1
        weightOnBridge -= bridge.removeFirst()
        
        guard !trucks.isEmpty,
              let truck = trucks.last
        else { continue }
        
        guard weightOnBridge + truck <= weight
        else { 
            bridge.append(empty)
            continue
        }
        
        weightOnBridge += truck
        bridge.append(trucks.removeLast())
    }
    
    return time
}
