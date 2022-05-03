# https://programmers.co.kr/learn/courses/30/lessons/72410

def is_possible(char):
    allowed_symbols = {".", "_", "-"}
    dup = {".", "_", "-", char}

    if char.isnumeric() or char.isalpha() or dup == allowed_symbols:
        return True
    return False


def solution(new_id: str):
    dot = "."
    answer = empty = ""
    for char in new_id:
        if is_possible(char) and not (answer != empty and answer[-1] == dot and char == dot):
            answer += char.lower()

    answer = answer.strip(dot)

    if answer == empty:
        answer = "a"

    if len(answer) >= 16:
        answer = answer[:15]

    answer = answer.strip(dot)

    while len(answer) < 3:
        answer += answer[-1]

    return answer