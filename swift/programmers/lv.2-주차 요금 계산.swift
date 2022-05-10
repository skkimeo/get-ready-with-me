//https://programmers.co.kr/learn/courses/30/lessons/92341

import Foundation

func totalTime(forCar car: Int, inLog: [Int]?, outLog: [Int]?) -> Int {
    let maxTime = "23:59".inMinutes
    var outLog = outLog ?? []
    outLog.append(maxTime)
    
    guard let inLog = inLog
    else { return .zero }
        
    var totalTime: Int = .zero
    
    for (inTime, outTime) in zip(inLog, outLog) {
        totalTime += outTime - inTime
    }
    
    return totalTime
}

func totalFee(forTime totalTime: Int, fees: [Int]) -> Int {
    let defaultTime = fees[0]
    let defaultFee = fees[1]
    let unitTime = fees[2]
    let extraFee = fees[3]
    
    var totalFee = defaultFee
    let overTime = totalTime - defaultTime
    
    guard overTime > .zero
    else { return totalFee }
    
    totalFee += Int(ceil(Double(overTime) / Double(unitTime))) * extraFee
    return totalFee
}

func parseRecords(_ records: [String]) -> (entered: [Int: [Int]], exited: [Int: [Int]]) {
    let isIn = "IN"
    let isOut = "OUT"
    
    var inLogs = [Int: [Int]]()
    var outLogs = [Int: [Int]]()

    records.forEach {
        let record = $0.components(separatedBy: " ")
        let time = record[0]
        let status = record[2]
        guard let car = Int(record[1])
        else { return }

        if status == isIn {
            inLogs[car, default: []].append(time.inMinutes)
            return
        }

        if status == isOut {
            outLogs[car, default: []].append(time.inMinutes)
        }
    }
    
    return (inLogs, outLogs)
}

func solution(_ fees:[Int], _ records:[String]) -> [Int] {
    var answer = [Int: Int]()
    
    let logs = parseRecords(records)
    
    logs.entered.keys.forEach { car in
        let time = totalTime(
            forCar: car,
            inLog: logs.entered[car],
            outLog: logs.exited[car]
        )
        answer[car] = totalFee(forTime: time, fees: fees)
    }

    return answer.sorted { $0.key < $1.key }.map { $0.value }
}

extension String {

    var inMinutes: Int {
        let time = self.components(separatedBy: ":").compactMap { Int($0) }
        let hour = time[0]
        let minute = time[1]
        
        return hour * 60 + minute
    }
}
