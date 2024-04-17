//
//  MeetingCellView.swift
//  Fasyn
//
//  Created by 김상금 on 4/17/24.
//

import SwiftUI

struct MeetingCellView: View {
    var meeting: Meeting
    
    var body: some View {
        VStack {
            HStack {
                Text(meeting.title)
                Spacer()
                Text(setDate(date: meeting.date))
            }
        }
    }
    
    private func setDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy년 M월 d일 a h시 m분"
        dateFormatter.locale = Locale(identifier:"ko_KR")
        let convertStr = dateFormatter.string(from: date)
        return convertStr
    }
}
