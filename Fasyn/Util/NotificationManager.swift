import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
    static let instance = NotificationManager()
    private init() {}
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("SUCCESS")
            }
        }
    }
    
    func scheduleNotification(for meeting: Meeting) {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a" // Customize format for time (e.g., 11:30 AM)
        
        
        content.title = "회의를 시작 할 시간이에요!"
        content.subtitle = "회의 주제 : \(meeting.title)"
        content.body = "시작 시간: \(formatter.string(from: meeting.date))"
        content.sound = .default
        content.badge = 1

        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: meeting.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false) // 반복 여부 설정 (false: 단 한번, true: 반복)

        let identifier = meeting.id.uuidString
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        center.add(request) { error in
            if let error = error {
                print("알림 예약 실패: \(error)")
            } else {
                print("알림 예약 성공: \(identifier)")
            }
        }
    }

    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
