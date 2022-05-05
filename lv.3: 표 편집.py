# https://programmers.co.kr/learn/courses/30/lessons/81303
import bisect
import collections


def solution(n, k, cmd):
    graph = [number for number in range(0, n)]
    removed = []
    multiplier = {"U": -1, "D": 1}

    for command in cmd:
        if command[0] == "C":
            remove = graph.pop(k)
            removed.append(remove)
            if graph[-1] < remove:
                k -= 1
            continue

        if command[0] == "Z":
            number = removed.pop()
            index = bisect.bisect_right(graph, number)
            graph.insert(index, number)
            if index <= k:
                k += 1
            continue

        direction, position = command.split()
        k += int(position) * multiplier[direction]

    counter = collections.Counter(graph)
    return "".join("O" if counter[i] else "X" for i in range(0, n))
