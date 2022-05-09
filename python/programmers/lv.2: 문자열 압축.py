# https://programmers.co.kr/learn/courses/30/lessons/60057

def solution(s):
    answer = 1e9

    # 길이별로 확인
    for length in range(1, len(s) + 1):
        start, prev, chunks = 0, None, []

        while s[start:start + length]:
            substring = s[start:start + length]
            # 압축 o
            if prev == substring:
                chunks[-1][1] += 1
            # 압축 x
            else:
                chunks.append([substring, 1])

            prev = substring
            start += length

        # 압축된 문자열 생성
        zipped_sentence = ""
        for substring, count in chunks:
            if count > 1:
                zipped_sentence += str(count)
            zipped_sentence += substring

        # 길이 비교
        answer = min(answer, len(zipped_sentence))

    return answer
