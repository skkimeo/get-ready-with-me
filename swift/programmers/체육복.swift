//https://programmers.co.kr/learn/courses/30/lessons/42862?language=swift
/**
 - 순서가 중요할 땐 항상 입력이 정렬되어 있는지 확인!
 **/

import Foundation

private var robbed = [Int]()
private var extra = Set<Int>()

func solution(_ n:Int, _ lost:[Int], _ reserve:[Int]) -> Int {
    initialize(lost: lost, reserve: reserve)
    borrowFromSelf()
    borrowFromPeer()
    
    return n - robbed.count
}
    
private func initialize(lost: [Int], reserve: [Int]) {
    robbed = lost.sorted()
    extra = Set(reserve)
}

private func borrowFromSelf() {
    for student in robbed {
        borrow(from: student, borrower: student)
    }
}

private func borrowFromPeer() {
    for student in robbed {
        guard !borrow(from: student - 1, borrower: student)
        else { continue }
        
        borrow(from: student + 1, borrower: student)
    }
}

@discardableResult
private func borrow(from lender: Int, borrower: Int) -> Bool {
    guard extra.contains(lender)
    else { return false }
    
    robbed.removeAll { $0 == borrower }
    extra.remove(lender)
    
    return true
}
