// https://programmers.co.kr/learn/courses/30/lessons/17679#
/**
    1. 배열의 x, y를 바꾼다(지워질 때 처리가 쉽도록)
    2. 판 전체를 완탐으로 돌면서 Set 에 사라질 블록들을 기록한다
      - [주의!] 완탐 시 모든 블록을 다 돌아야 아래와 같은 경우의 블록을 다 기록할 수 있음((0,0)을 통해 4칸을 확인했다고 건너뛰면 마지막 열 누락됨)
            aaa
            aaa
    3 - 1 Set 이 비어있으면 종료한다
    3 - 2 Set 이 비어있지 않으면 삭제 작업을 하고 다시 2로 돌아간다.
 
**/

import Foundation

private var rotatedBoard = [[String]]()
private let empty = "0"

struct Point: Hashable {
    let x: Int
    let y: Int
}

func solution(_ m:Int, _ n:Int, _ board:[String]) -> Int {
    rotateBoard(board, m: m, n: n)
    var answer = Int.zero
    
    while true {
        let popBlocks = findPopBlocks()
        guard !popBlocks.isEmpty
        else { break }
        
        answer += popBlocks.count
        removePopBlocks(popBlocks)
    }
    
    return answer
}

private func removePopBlocks(_ blocks: Set<Point>) {
    let blocks = blocks.sorted { $0.y > $1.y }
    
    for block in blocks {
        rotatedBoard[block.x].remove(at: block.y)
        rotatedBoard[block.x].append(empty)
    }
}

private func findPopBlocks() -> Set<Point> {
    let rowCount = rotatedBoard.count
    let columnCount = rotatedBoard[0].count
    var popBlocks = Set<Point>()
    
    for row in Int.zero..<rowCount - 1 {
        for column in Int.zero..<columnCount - 1 {
            guard let blocks = squareWithStartingPoint(Point(x: row, y: column))
            else { continue }
            
            popBlocks.formUnion(blocks)
        }
    }
    
    return popBlocks
}

private func squareWithStartingPoint(_ point: Point) -> Set<Point>? {
    let dx = [0, 1, 1]
    let dy = [1, 0, 1]
    let character = rotatedBoard[point.x][point.y]
    var square: Set<Point> = [point]
    
    guard character != empty
    else { return nil }
    
    for i in Int.zero..<3 {
        let nx = point.x + dx[i]
        let ny = point.y + dy[i]
        guard rotatedBoard[nx][ny] == character
        else { return nil }
        
        square.insert(Point(x: nx, y: ny))
    }
    return square
}

private func rotateBoard(_ array: [String], m: Int, n: Int) {
    let array = array.map { $0.map { String($0) }}
    for column in Int.zero..<n {
        var temp = [String]()
        for row in Int.zero..<m {
            temp.append(array[row][column])
        }
        rotatedBoard.append(temp.reversed())
    }
}
