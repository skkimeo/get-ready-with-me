# https://programmers.co.kr/learn/courses/30/lessons/81302

import itertools

participant, table, partition = "P", "O", "X"
INF = 1e9


def find_all_participants_in_each_room(places):
    participants = [[] for _ in range(0, 5)]

    for number in range(0, 5):
        for row in range(0, 5):
            for col in range(0, 5):
                if places[number][row][col] == participant:
                    participants[number].append((row, col))

    return participants


def is_keeping_social_distance(pos1, pos2, room):
    (x1, y1), (x2, y2) = pos1, pos2
    dx, dy = abs(x1 - x2), abs(y1 - y2)
    manhattan_distance = dx + dy

    if manhattan_distance > 2:
        return True

    if manhattan_distance == 2:
        if (dx and dy and room[x1][y2] == partition and room[x2][y1] == partition) \
                or (not dx and room[x1][min(y1, y2) + 1] == partition) \
                or (not dy and room[min(x1, x2) + 1][y1] == partition):
            return True

    return False


def solution(places):
    answer = [INF for _ in range(0, 5)]
    participants = find_all_participants_in_each_room(places)

    for number in range(0, 5):
        combos = itertools.combinations(participants[number], 2)

        for pos1, pos2 in combos:
            if not is_keeping_social_distance(pos1, pos2, places[number]):
                answer[number] = 0
                break

        answer[number] = 1 if answer[number] == INF else 0

    return answer
