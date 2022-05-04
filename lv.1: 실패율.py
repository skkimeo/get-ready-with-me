# https://programmers.co.kr/learn/courses/30/lessons/42889

import collections
import copy


def solution(N, stages):
    failure_per_stage = []
    failures = collections.Counter(stages)
    counter = copy.deepcopy(failures)

    # 스테이지별 인원 계산
    for stage in range(2, N + 2):
        users = counter[stage]
        for prev in range(1, stage):
            counter[prev] += users

    # 실패율 계산
    for stage in range(1, N + 1):
        try:
            failure_rate = failures[stage] / counter[stage]
            failure_per_stage.append((stage, failure_rate))
        except ZeroDivisionError:
            failure_per_stage.append((stage, 0))

    # 정렬
    return [data[0] for data in sorted(failure_per_stage, key=lambda x: -x[1])]