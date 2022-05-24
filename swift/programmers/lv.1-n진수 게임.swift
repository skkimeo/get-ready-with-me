// https://programmers.co.kr/learn/courses/30/lessons/17687?language=swift

func solution(_ n:Int, _ t:Int, _ m:Int, _ p:Int) -> String {
    var answer = ""
    var count = t
    var number = Int.zero
    var turn = Int.zero
    
    outer: while count != .zero {
        for character in number.convertRadix(to: n) {
            turn = (turn == m) ? 1 : turn + 1
            
            guard turn == p
            else { continue }
            
            count -= 1
            answer.append(character)
            
            guard count == .zero
            else { continue }
            
            break outer
        }
        number += 1
    }
    
    return answer
}

extension Int {
    
    func convertRadix(to number: Int) -> String {
        String(self, radix: number, uppercase: true)
    }
}
