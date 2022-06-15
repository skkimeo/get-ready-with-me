// https://programmers.co.kr/learn/courses/30/lessons/72411?language=swift

import Foundation

private var menus = [String: Int]()

func solution(_ orders:[String], _ course:[Int]) -> [String] {
    var answer = [String]()
    
    for itemCount in course { 
        orders.forEach { makeMenu(of: itemCount, orders: $0, result: "") }
        answer += mostPopularMenus()
        menus = [:]
    }
    return answer.sorted()
}

private func mostPopularMenus() -> [String] {
    guard let maxCount = menus.values.max(),
              maxCount >= 2
    else { return [] }
    
    return menus.filter { $0.value == maxCount }.keys.map { $0 }
}

private func makeMenu(of count: Int, orders: String, result: String) {
    guard count != Int.zero
    else { return menus[result.sorted().reduce("") { $0 + String($1) }, default: .zero] += 1 }
    
    var subOrders = orders
    
    orders.reversed().forEach { 
        subOrders.popLast()
        guard subOrders.count >= count - 1
        else { return }
        
        makeMenu(of: count - 1, orders: subOrders, result: String($0) + result)
    }
}