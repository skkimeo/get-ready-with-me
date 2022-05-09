# https://programmers.co.kr/learn/courses/30/lessons/67256

def solution(numbers, hand):
    asterisk, hash = 10, 11
    left, right = asterisk, hash
    answer = ''

    position = [
        [3, 1],
        [0, 0], [0, 1], [0, 2],
        [1, 0], [1, 1], [1, 2],
        [2, 0], [2, 1], [2, 2],
        [3, 0], [3, 2]
    ]

    for number in numbers:
        x, y = position[number][0], position[number][1]

        if number in [1, 4, 7]:
            answer += "L"
            left = number
            continue

        if number in [3, 6, 9]:
            answer += "R"
            right = number
            continue

        left_distance = abs(position[left][0] - x) + abs(position[left][1] - y)
        right_distance = abs(position[right][0] - x) + abs(position[right][1] - y)

        if left_distance < right_distance or (left_distance == right_distance and hand == "left"):
            answer += "L"
            left = number
        else:
            answer += "R"
            right = number

    return answer
