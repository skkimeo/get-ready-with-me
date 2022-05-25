// https://programmers.co.kr/learn/courses/30/lessons/17686

import Foundation

private func parseFiles(_ files: [String]) -> [(head: String, number: Int, name: String)] {
    var parsedFiles = [(String, Int, String)]()
    
    files.forEach {
        guard let head = $0.components(separatedBy: .decimalDigits).first,
              let numberString = $0.split(whereSeparator: { !$0.isNumber }).first,
              let number = Int(numberString)
        else { return }
        
        parsedFiles.append((head, number, $0))
    }
    
    return parsedFiles
}

func solution(_ files:[String]) -> [String] {
    parseFiles(files)
        .sorted {
            guard $0.head.lowercased() == $1.head.lowercased()
            else { return $0.head.lowercased() < $1.head.lowercased() }
            
            return ($0.number == $1.number) ? false : $0.number < $1.number
        }
        .compactMap { $0.name }
}
