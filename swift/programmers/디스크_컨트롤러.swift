/**
https://programmers.co.kr/learn/courses/30/lessons/42627?language=swift#
- 나름대로 예외 처리는 잘 생각했는데 막상 구현에서 한 가지씩 놓쳐서 또 다시 지옥의 두더지 잡기...^^
- 우선순위 큐를 써야겠다고 생각했는데 현재 시점까지만 도착하면 요청 시간에 관계 없이 무조건 작업 시간이 빠른 Shortest Job First 스케줄링 방식이기 때문에 아직 도착하지 않은 작업들과 대기 중인 작업들을 별도의 배열에 담아서 처리하면 되겠다고 생각했다.
- 전자는 그냥 (역으로) 정렬한 배열으로 충분하고 후자는 우선순위 큐가 딱이었는데 파이썬으로 풀었을 때는 실제로 우선순위 큐를 썼지만 스위프트에는 그런 거 없으니까...나름대로 꼼수를 써서 스택에 거꾸로 정렬해서(빨리 처리해야 되는 게 뒤에 오도록) 짭 우선순위큐처럼 썼다. 어차피 실제 코테때 시간 내에 언제 우선순위큐까지 구현하겠어 하는 생각 때문이었음 변명 아님
 - 요청 전 -> 대기중으로 이동할 때 정렬을 하도록 했더니 작업을 요청할 때마다 하는 것보다 효율적이었다. 보통 여러 작업이 동시에 대기큐로 이동하면서 모든 작업이 완료되기 훨씬 전에 요청큐가 다 비기 때문일듯..
- 문제에서 (나한테) 가장 놓치면 안돼!!! 싶었던 부분은 다음 작업이 마지막 작업이 끝나고 나서 한참 뒤에 들어오는 경우(e.g. 3초에 이미 기존 작업은 다 끝났는데 다음 작업은 빨라야 5초에나 들어오는 경우)였다. 처음부터 잘 고려해서 작업 하나를 완료하고 완료 시점까지 새로운 작업이 들어왔는지 확인할 때, 대기큐가 비어있다면 현재를 기준으로는 들어온 작업이 없더라도 아직 요청되지 않은 작업이 남아있다면 가장 빠른 작업을 가져오도록 잘 구현했는데, 막상 해당 작업을 처리할 때 요청~작업 종료까지의 시간을 구하는 로직을 제대로 안 짜서 또 다시 시간을 태우고...
- 참고로 소요 시간이 같다면 일찍 도착한 작업을 먼저 수행하는 게 이득일 줄 알았는데 이건 상관없었다...
**/

import Foundation

private var waiting = [[Int]]()
private var notArrived = [[Int]]()

func solution(_ jobs:[[Int]]) -> Int {
    notArrived = jobs.sorted {
        guard $0[0] == $1[0]
        else { return $0[0] > $1[0] }
        
        return $0[1] > $1[1]
    }

    var startTime = notArrived.last![0]
    findWaitingJobs(startingFrom: startTime)

    var totalTime = Int.zero
    while !waiting.isEmpty {
        let job = shortestJobFirst()
        let waitTime = (startTime > job[0]) ? startTime - job[0] : .zero
        totalTime += job[1] + (waitTime > .zero ? waitTime : .zero)
        startTime = job[1] + (waitTime > .zero ? startTime : job[0] )
        findWaitingJobs(startingFrom: startTime)
    }
    
    return totalTime / jobs.count
}

private func shortestJobFirst() -> [Int] {
    waiting.removeLast()
}

private func findWaitingJobs(startingFrom time: Int) {
    guard !notArrived.isEmpty
    else { return }
    
    while !notArrived.isEmpty {
        guard notArrived.last![0] <= time
        else { break }
        
        waiting.append(notArrived.removeLast())
    }
    
    if waiting.isEmpty {
        let fastest = notArrived.last![0]
        while !notArrived.isEmpty {
            guard notArrived.last![0] == fastest
            else { break }
            
            waiting.append(notArrived.removeLast())
        }
    }
    
    waiting = waiting.sorted {
        guard $0[1] == $1[1]
        else { return $0[1] > $1[1] }
        
        return $0[0] > $1[0]
    }
}
