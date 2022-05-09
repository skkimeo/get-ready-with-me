// https://programmers.co.kr/learn/courses/30/lessons/92334

import Foundation

func solution(_ id_list:[String], _ report:[String], _ k:Int) -> [Int] {
    
    var mailingList = [String: Set<String>]()
    var deathNote = [String: Int]()
    
    let REPORTER = 0
    let REPORTED = 1
    
    id_list.forEach {
        mailingList[$0] = []
        deathNote[$0] = .zero
    }
    
    report.forEach {
        let data = $0.split(separator: " ")
        let reporter = String(data[REPORTER])
        let reported = String(data[REPORTED])
        
        guard mailingList[reporter]?.contains(reported) == false,
              deathNote[reported] != nil
        else { return }
        
        mailingList[reporter]?.insert(reported)
        deathNote[reported]! += 1
    }
    
    let suspendedIDs = Set(deathNote.compactMap { $0.value >= k ? $0.key : nil })
    var answer = [Int]()
    
    id_list.forEach {
        guard let mailingList = mailingList[$0]
        else { return }
        
        let mailCounts = mailingList.filter { suspendedIDs.contains($0) }.count
        answer.append(mailCounts)
    }
    
    return answer
}
