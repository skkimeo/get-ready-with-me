# https://programmers.co.kr/learn/courses/30/lessons/64061

def solution(board: list, moves):
    basket = [-1]
    answer = 0
    row, col = len(board), len(board[0])
    board.reverse()
    new_board = [[0] for _ in range(0, col + 1)]

    for x in range(0, row):
        for y in range(0, col):
            doll = board[x][y]
            if doll:
                new_board[y + 1] += [doll]

    for move in moves:
        if new_board[move][-1]:
            selected_doll = new_board[move].pop()
            if basket[-1] == selected_doll:
                basket.pop()
                answer += 2
            else:
                basket += [selected_doll]
    return answer
