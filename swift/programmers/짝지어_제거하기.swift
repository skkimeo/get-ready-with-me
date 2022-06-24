// https://programmers.co.kr/learn/courses/30/lessons/12973
/**
- reduce 메서드는 재귀 함수이므로 실행시간이 길어서 시간 초과났음... 
- 똑같은 풀이인데 그냥 반복문으로 바꿨더니 바로 효율성까지 통과...!
**/

import Foundation

func solution(_ s:String) -> Int {
    var stack = [Character]()
    
    for character in s {
        guard let last = stack.last,
              character == last
        else { 
            stack.append(character) 
            continue
        }
        
        stack.removeLast()
    }
    
    return stack.isEmpty ? 1 : 0
}
