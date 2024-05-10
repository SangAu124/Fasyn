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
    
    enum TriggerType: String {
        case time = "time"
        case calendar = "calendar"
        case location = "location"
        
        var trigger: UNNotificationTrigger {
            switch self {
            case .time:
                return UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            case .calendar:
                let dateComponents = DateComponents(hour: 20, minute: 26, weekday: 2)
                return UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            case .location:
                let coordinate = CLLocationCoordinate2D(latitude: 40.0, longitude: 50.0)
                let region = CLCircularRegion(center: coordinate, radius: 100, identifier: UUID().uuidString)
                region.notifyOnExit = false
                region.notifyOnEntry = true
                return UNLocationNotificationTrigger(region: region, repeats: true)
            }
        }
    }
    
    func scheduleNotification(trigger: TriggerType) {
        let content = UNMutableNotificationContent()
        content.title = "회의를 시작 할 시간이에요!"
        content.subtitle = "구성원들에게 연락을 돌려볼까용?"
        content.sound = .default
        content.badge = 1
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger.trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    
    func scheduleNotification(for meeting: Meeting) {
        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = meeting.title
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a" // Customize format for time (e.g., 11:30 AM)
        content.body = "회의 시작: \(formatter.string(from: meeting.date))"

        let sound = UNNotificationSound.default

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
