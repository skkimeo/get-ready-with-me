//https://programmers.co.kr/learn/courses/30/lessons/42586?language=swift

import Foundation

func solution(_ progresses:[Int], _ speeds:[Int]) -> [Int] {
    return zip(progresses, speeds)
        .map { calculateWorkLoad(for: $0, speed: $1) }
        .reduce((answer: [], maxWorkLoad: Int.zero)) {
            guard !$0.answer.isEmpty,
                  $1 <= $0.maxWorkLoad
            else { return ($0.answer + [1], $1) }

            var answer = $0.answer
            answer.append(answer.removeLast() + 1)
            return (answer, $0.maxWorkLoad)
        }
        .answer
}

private func calculateWorkLoad(for progress: Int, speed: Int) -> Int {
    Int(ceil((100 - Double(progress)) / Double(speed)))
}
