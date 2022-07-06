// https://school.programmers.co.kr/learn/courses/30/lessons/12901

import Foundation 

func solution(_ a:Int, _ b:Int) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy M d"
    let date = formatter.date(from: "2016 \(a) \(b)")!
    formatter.dateFormat = "E"

    return formatter.string(from: date).uppercased()
}
