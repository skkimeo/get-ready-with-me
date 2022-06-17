//https://programmers.co.kr/learn/courses/30/lessons/42579?language=swift#

import Foundation

private var bestAlbum = [String: [(id: Int, count: Int)]]()

func solution(_ genres:[String], _ plays:[Int]) -> [Int] {
    parseData(genres: genres, plays: plays)
    return bestAlbum.values
        .sorted { left, right in
            left.reduce(0) { $0 + $1.count } > right.reduce(0) { $0 + $1.count }
        }.flatMap { songs in
            songs.sorted {
                guard $0.count == $1.count
                else { return $0.count > $1.count }
                return $0.id < $1.id
            }
            .prefix(2)
            .map { $0.id }
        }
}

private func parseData(genres: [String], plays: [Int]) {
    for (index, (genre, playCount)) in zip(genres, plays).enumerated() {
        bestAlbum[genre, default: []].append((index, playCount))
    }
}
