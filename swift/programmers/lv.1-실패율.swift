// https://programmers.co.kr/learn/courses/30/lessons/42889?language=swift

import Foundation

private func parseUserData(_ userData: [Int], n: Int) -> [Int] {
    var usersOnStage = Array(repeating: Int.zero, count: n + 2)
    userData.forEach { usersOnStage[$0] += 1 }
    
    return usersOnStage
}

private func calculateFailureRate(usingData data: [Int]) -> [(failureRate: Double, stage: Int)] {
    var usersOnStage = data
    
    guard let allClearUsers = usersOnStage.popLast()
    else { return [] }
    
    var failureRates = [(failureRate: Double, stage: Int)]()
    var accumulatedUsers = allClearUsers
    
    for (stage, users) in usersOnStage.enumerated().reversed() {
        accumulatedUsers += users
        
        guard accumulatedUsers != .zero
        else {
            failureRates.append((.zero, stage))
            continue
        }
        
        let failureRate = Double(users) / Double(accumulatedUsers)
        failureRates.append((failureRate, stage))
    }
    
    failureRates.popLast()
    
    return failureRates
}

func solution(_ N:Int, _ stages:[Int]) -> [Int] {
    let usersOnStage = parseUserData(stages, n: N)
    let failureRates = calculateFailureRate(usingData: usersOnStage)
    
    return failureRates
        .sorted {
            ($0.failureRate != $1.failureRate) ?
            $0.failureRate > $1.failureRate : $0.stage < $1.stage
        }
        .compactMap { $0.stage }
}
