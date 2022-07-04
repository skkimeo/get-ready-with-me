/**
 
 1. 노드 수가 많지 않아서 오 이건 dfs/bfs로 다 돌아야겠다 싶었다
 
 2. 근데 이제 다시 부모 노드로 돌아갈 수도 있고, 양과 늑대 수에 따라서 못 갔던 길이 열리기도 하니까 간선이 단방향이 아니라 양방향이라고 생각해서, 파싱할 때 부모/자식 노드를 가리지 않고 연결된 노드로 기록했는데...
 
 3. 그러고 나서 각 지점에 올 때마다 갈 수만 있으면 연결된 노드를 다 탐방하게 했더니 무한 루프가 발생했던 것이에요...
    - 왜냐면 계속 되돌아갈 수 있으니까 노드가 다 소모될 일이 없어서 탈출 조건이 없는 상태가 되어버리고 결국 걍 계속 움직일 수 있는 범위 내에서 깔짝깔짝 거리는 거였음
 
 4. 방문기록으로 탈출조건을 설정해줘야겠다고 생각했는데(이미 온 적 있으면 더 깊이 탐색 안하게) 그 와중에 어디로 이동하느냐에 따라 새로운 길이 열리니까 단순히 방문 기록만으로는 처리할 수 없었음 왜냐면 아까 방문했어도 양을 하나 얻은 나는 더 강해졌으니까 거기를 거쳐서 이제 새로운 곳을 갈 수 있을 수도 있거든요....여기부터 고통 시작....^^
 
 5. 일단 자고 일어났더니 새로운 양을 하나 얻는 순간 새로운 길 해금 가능성이 열리니까 이때마다 방문 기록을 리셋하면 되겠다 싶었다 유레카!!!!
    - 코테 때는 못 자는 데 어카냐...
 6. 근데 사실 이거 예전에 어디선가 풀이 접근 방법 슥 봐서 그거 기억에 남아서 푼 듯...ㅋㅋㅋㅋㅋ
 
 **/

import Foundation

func solution(_ info:[Int], _ edges:[[Int]]) -> Int {
    return dfs(
        info: info,
        edges: parseEdges(edges),
        point: .zero,
        sheep: 0,
        wolves: .zero,
        visited: Array(repeating: false, count: 17)
    )
}

func dfs(
    info: [Int],
    edges: [[Int]],
    point: Int,
    sheep: Int,
    wolves: Int,
    visited: [Bool]
) -> Int {
    var info = info
    var visited = visited
    var sheep = sheep
    var wolves = wolves
    
    if info[point] == 0 {
        visited = Array(repeating: false, count: 17)
        sheep += 1
    } else if info[point] == 1 {
        wolves += 1
    }
    
    guard sheep - wolves > .zero
    else { return info[point] == 1 ? sheep - 1 : sheep }
    
    visited[point] = true
    info[point] = -1
    var maxSheep = sheep
    
    
    for next in edges[point] {
        guard !visited[next]
        else { continue }
        
        let result = dfs(
            info: info,
            edges: edges,
            point: next,
            sheep: sheep,
            wolves: wolves,
            visited: visited
        )
        maxSheep = max(maxSheep, result)
    }
    return maxSheep
}

private func parseEdges(_ edges: [[Int]]) -> [[Int]] {
    var array = Array(repeating: [Int](), count: 17)
    
    let edges = edges.sorted {
        guard $0[0] == $1[0]
        else { return $0[0] < $1[0] }
        
        return $0[1] < $1[1]
    }
    
    for edge in edges {
        array[edge[0]].append(edge[1])
        array[edge[1]].append(edge[0])
    }
    
    return array
}
