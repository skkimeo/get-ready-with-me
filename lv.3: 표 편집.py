# https://programmers.co.kr/learn/courses/30/lessons/81303

def solution(n, k, cmd):
    ok_mark, x_mark = "O", "X"
    answer, removed = [ok_mark] * n, []
    prev, next = 0, 1
    selected = k
    clear, restock, up, down = "C", "Z", "U", "D"
    multiplier = {up: prev, down: next}
    graph = [[None, 1]]
    for number in range(1, n - 1):
        graph.append([number - 1, number + 1])
    graph.append([n - 2, None])

    for command in cmd:
        if command[-1] == clear:
            answer[selected] = x_mark
            leading, trailing = graph[selected][prev], graph[selected][next]
            removed.append((selected, leading, trailing))
            if leading is not None:
                graph[leading][next] = trailing
                selected = leading
            if trailing is not None:
                graph[trailing][prev] = leading
                selected = trailing
            continue

        if command[-1] == restock:
            number, leading, trailing = removed.pop()
            graph[number] = [leading, trailing]
            answer[number] = ok_mark
            if leading is not None:
                graph[leading][next] = number
            if trailing is not None:
                graph[trailing][prev] = number
            continue

        direction, count = command.split()
        for _ in range(int(count)):
            selected = graph[selected][multiplier[direction]]

    return "".join(answer)
