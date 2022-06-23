//https://programmers.co.kr/learn/courses/30/lessons/17683
/**
- 재생 시간과 순서를 모두 기록해야 함
- C와 C# 을 구분할 수 있어야 함
   - 이런 문제의 경우 두글자 이상인 요소를 한글자의 다른 요소로 치환하는 게 처리가 가장 쉬움
   - @ 문자열에서 특정 문자 치환할 때는 replacingOccurences(of:with:) 사용하기 
**/

import Foundation

private let none = "(None)"

struct Music {
    let time: Int
    let title: String
    let melody: String
}

func solution(_ m:String, _ musicinfos:[String]) -> String {
    let melody = convertMelody(m)
    return findMusicWithMelody(melody, musicInfos: parseMusicInfo(musicinfos))?.title ?? none
}

private func parseMusicInfo(_ musicInfo: [String]) -> [Music] {
    musicInfo.map { music in
        let music = music.components(separatedBy: ",")
        let time = convertToMinutes(music[1]) - convertToMinutes(music[0])
        return Music(time: time, title: music[2], melody: makeMelody(music[3], time: time))
    }
}

private func makeMelody(_ melody: String, time: Int) -> String {
    let array = convertMelody(melody).map { String($0) }
    let length = array.count
    return (0..<time).reduce("") { $0 + array[$1 % length] }
}

private func convertMelody(_ melody: String) -> String {
    melody.replacingOccurrences(of: "C#", with: "c")
        .replacingOccurrences(of: "D#", with: "d")
        .replacingOccurrences(of: "F#", with: "f")
        .replacingOccurrences(of: "G#", with: "g")
        .replacingOccurrences(of: "A#", with: "a")
}

private func convertToMinutes(_ time: String) -> Int {
    let time = time.components(separatedBy: ":").compactMap { Int($0) }
    return time[0] * 60 + time[1]
}

private func findMusicWithMelody(_ melody: String, musicInfos: [Music]) -> Music? {
    musicInfos.reduce(Music?.none) {
        guard $1.melody.contains(melody),
              $1.time > $0?.time ?? .zero
        else { return $0 }
        
        return $1
    }
}
