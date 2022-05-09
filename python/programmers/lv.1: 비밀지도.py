# https://programmers.co.kr/learn/courses/30/lessons/17681

def solution(n, arr1, arr2):
    answer = []
    for number in range(0, n):
        wall = bin(arr1[number] | arr2[number] | 2 ** n)[-n:]
        wall = wall.replace("0", " ")
        wall = wall.replace("1", "#")
        answer.append(wall)

    return answer
