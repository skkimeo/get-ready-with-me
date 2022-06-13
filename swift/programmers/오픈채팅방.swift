// https://programmers.co.kr/learn/courses/30/lessons/42888?language=swift

import Foundation

private enum Event: String {
    case enter = "Enter"
    case leave = "Leave"
    case change = "Change"

    var message: String {
        if self == .enter { return "님이 들어왔습니다." }
        if self == .leave { return "님이 나갔습니다." }
        return ""
    }
}

private let event = 0
private let id = 1
private let nickname = 2

private var nicknames = [String:String]()
private var log = [(id: String, event: Event)]()

func solution(_ record:[String]) -> [String] {
    record.forEach {
        let data = $0.components(separatedBy: " ")
        let currentEvent = Event(rawValue: data[event])!

        guard currentEvent != Event.leave
        else { return log.append((data[id], currentEvent)) }

        nicknames[data[id]] = data[nickname]

        guard currentEvent == Event.enter
        else { return }
        log.append((data[id], currentEvent))
    }

    return log.map { "\(nicknames[$0.id, default: ""])" + $0.event.message }
}
