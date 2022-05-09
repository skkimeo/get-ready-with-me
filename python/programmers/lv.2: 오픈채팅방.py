# https://programmers.co.kr/learn/courses/30/lessons/42888
# import

enter, leave, change = "Enter", "Leave", "Change"


# 로그에 최종 닉네임 반영
def create_message(log, nicknames):
    messages = []
    for action, id in log:
        if action == enter:
            messages.append(f"{nicknames[id]}님이 들어왔습니다.")
            continue
        if action == leave:
            messages.append(f"{nicknames[id]}님이 나갔습니다.")
    return messages


def solution(record):
    answer, log, nicknames = [], [], {}
    action, id, nickname = 0, 1, 2

    # 기록 파싱
    for data in record:
        data = data.split()
        if data[action] != leave:
            nicknames[data[id]] = data[nickname]
        if data[action] != change:
            log.append((data[action], data[id]))

    return create_message(log, nicknames)
