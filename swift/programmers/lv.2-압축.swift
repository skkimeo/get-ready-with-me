// https://programmers.co.kr/learn/courses/30/lessons/17684

import Foundation

// MARK: - Properties

private var dictionary: [String: Int] = {
    var dictionary = [String: Int]()
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ".enumerated().forEach {
        dictionary[String($0.element)] = $0.offset + 1
    }
        
    return dictionary
}()

private var message = [String]()

private var currentLongestSubStringValue: Int {
    var input = ""
    var output = Int.zero
    
    while !message.isEmpty {
        input.append(message.last!)
        
        guard let value = dictionary[input]
        else {
            updateDictionaryIfNeeded(key: input)
            break
        }
        output = value
        message.removeLast()
    }
    
    return output
}


// MARK: - Fuctions 

func solution(_ msg:String) -> [Int] {
    message = msg.reversed().map { String($0) }
    return compressMessage()
}

private func compressMessage() -> [Int] {
    var answer = [Int]()
    
    while !message.isEmpty {
        answer.append(currentLongestSubStringValue)
    }
    
    return answer
}

private func updateDictionaryIfNeeded(key: String) {
    dictionary[key] = dictionary.count + 1
}