# https://programmers.co.kr/learn/courses/30/lessons/81303

def solution(n, k, cmd):
    ok_mark, x_mark = "O", "X"
    answer, removed = [ok_mark] * n, []
    prev, next = 0, 1
    selected = k
    clear, restock, up, down = "C", "Z", "U", "D"
    multiplier = {up: prev, down: next}
    graph = [[None, 1]]
    for number in range(1, n - 1):
        graph.append([number - 1, number + 1])
    graph.append([n - 2, None])

    for command in cmd:
        if command[-1] == clear:
            answer[selected] = x_mark
            leading, trailing = graph[selected][prev], graph[selected][next]
            removed.append((selected, leading, trailing))
            if leading is not None:
                graph[leading][next] = trailing
                selected = leading
            if trailing is not None:
                graph[trailing][prev] = leading
                selected = trailing
            continue

        if command[-1] == restock:
            number, leading, trailing = removed.pop()
            graph[number] = [leading, trailing]
            answer[number] = ok_mark
            if leading is not None:
                graph[leading][next] = number
            if trailing is not None:
                graph[trailing][prev] = number
            continue

        direction, count = command.split()
        for _ in range(int(count)):
            selected = graph[selected][multiplier[direction]]

    return "".join(answer)


# 링크드리스트
class Node:
    def __init__(self, number, prev):
        self.number = number
        self.prev = prev
        self.next = None


class LinkedList:
    def __init__(self, number, k):
        self.root = Node(0, None)
        self.selected_node = None
        self.removed = []
        node = self.root
        for index in range(1, number):
            new_node = Node(index, node)
            node.next = new_node
            node = new_node
            if index == k:
                self.selected_node = new_node

    def up(self, count):
        for _ in range(count):
            if self.selected_node.prev:
                self.selected_node = self.selected_node.prev

    def down(self, count):
        for _ in range(count):
            if self.selected_node.next:
                self.selected_node = self.selected_node.next

    def clear(self):
        removed_number = self.selected_node.number
        self.removed.append(self.selected_node)

        if self.selected_node.prev:
            self.selected_node.prev.next = self.selected_node.next
        if self.selected_node.next:
            self.selected_node.next.prev = self.selected_node.prev
        if self.selected_node.next:
            self.selected_node = self.selected_node.next
        elif self.selected_node.prev:
            self.selected_node = self.selected_node.prev
        return removed_number

    def restock(self):
        node = self.removed.pop()
        if node.prev:
            node.prev.next = node
        if node.next:
            node.next.prev = node

        return node.number


def solution_2(n, k, cmd):
    ok_mark, x_mark = "O", "X"
    answer = [ok_mark] * n
    clear, restock, up, down = "C", "Z", "U", "D"

    linked_list = LinkedList(n, k)
    for command in cmd:
        if command[-1] == clear:
            index = linked_list.clear()
            answer[index] = x_mark
            continue

        if command[-1] == restock:
            index = linked_list.restock()
            answer[index] = ok_mark
            continue

        direction, count = command.split()
        count = int(count)
        if direction == up:
            linked_list.up(count)
            continue

        if direction == down:
            linked_list.down(count)

    return "".join(answer)
