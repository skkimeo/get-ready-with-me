// https://programmers.co.kr/learn/courses/30/lessons/43164
/**
    - Set 사용 전에는 반드시 중복이 없는 지 확인하기 
    - 처음에 무지성으로 티켓을 Set으로 바꿔서 풀었더니 1번 테케에서 세그폴트 떴음...ㅠ 
**/

import Foundation

private let departure = 0
private let arrival = 1
private let start = "ICN"

func solution(_ tickets:[[String]]) -> [String] {
    dfs(start: start, visited: [], tickets: tickets).sorted { $0.joined() < $1.joined() }.first!
}

private func dfs(start: String, visited: [String], tickets: [[String]]) -> [[String]] {
    let visited = visited + [start]
    
    guard !tickets.isEmpty
    else { return [visited] }
    
    var routes = [[String]]()
    var tickets = tickets
    
    for (index, ticket) in tickets.enumerated() {
        guard ticket[departure] == start
        else { continue }
        
        tickets.remove(at: index)
        routes += dfs(start: ticket[arrival], visited: visited, tickets: tickets)
        tickets.insert(ticket, at: index)
    }
    
    return routes
}
