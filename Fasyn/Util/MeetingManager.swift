//
//  MeetingManager.swift
//  Fasyn
//
//  Created by 상dev on 5/14/24.
//

import Foundation

class MeetingsManager {
    static let shared = MeetingsManager()
    
    private let key = "Meetings"
    
    // Meetings 배열을 UserDefaults에 저장하는 함수
    func saveMeetings(_ meetings: [Meeting]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(meetings) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    func saveMeeting(_ meeting: Meeting) {
        var meetings = loadMeetings()
        meetings.append(meeting)
        saveMeetings(meetings)
    }
    
    // UserDefaults에서 Meetings 배열을 가져오는 함수
    func loadMeetings() -> [Meeting] {
        if let savedMeetings = UserDefaults.standard.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let loadedMeetings = try? decoder.decode([Meeting].self, from: savedMeetings) {
                return loadedMeetings
            }
        }
        return []
    }
    
    // UserDefaults에서 Meeting 배열을 가져와 인자로 들어온 Meeting을 삭제 하는 함수
    func deleteMeeting(_ meeting: Meeting) {
        var meetings = loadMeetings()
        if let index = meetings.firstIndex(where: { $0.id == meeting.id }) {
            meetings.remove(at: index)
            saveMeetings(meetings)
        }
    }
}
