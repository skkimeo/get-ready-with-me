# https://programmers.co.kr/learn/courses/30/lessons/17677

from collections import Counter


def make_set(string: str):
    multiple_sets = []

    for index in range(0, len(string) - 1):
        substring = string[index: index + 2]
        if substring.isalpha():
            multiple_sets.append(substring.lower())

    return multiple_sets


def solution(str1, str2):
    counter1, counter2 = Counter(make_set(str1)), Counter(make_set(str2))

    union = sum((counter1 | counter2).values())
    intersection = sum((counter1 & counter2).values())

    return int((intersection / union if union else 1) * 65536)
