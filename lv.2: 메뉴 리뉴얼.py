# https://programmers.co.kr/learn/courses/30/lessons/72411

from itertools import combinations
from collections import Counter


def make_new_course_if_possible(candidates):
    courses = []

    if not candidates:
        return courses

    candidates = candidates.most_common()
    max_popularity = candidates[0][1]
    for combo, popularity in candidates:
        if popularity > 1 and popularity == max_popularity:
            courses.append(combo)
        else:
            break

    return courses


def solution(orders, course):
    courses = []

    # 스카피가 원하는 메뉴 개수마다 후보 모두 확인
    for number in course:
        candidates = Counter()
        for order in orders:
            combos = ["".join(char for char in sorted(combo)) for combo in combinations(order, number)]
            candidates += Counter(combos)

        courses += make_new_course_if_possible(candidates)

    return sorted(courses)
