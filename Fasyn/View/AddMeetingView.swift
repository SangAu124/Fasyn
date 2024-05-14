//
//  AddMeetingView.swift
//  Fasyn
//
//  Created by 김상금 on 4/17/24.
//

import SwiftUI

struct AddMeetingView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var meetings: [Meeting]
    @State private var meetingTitle = ""
    @State private var selectedDate = Date() // 선택된 날짜를 추적하는 상태 변수
    let manager = NotificationManager.instance
    
    var body: some View {
        NavigationView {
            ScrollViewReader { proxy in
                ScrollView(showsIndicators: false) {
                    VStack {
                        VStack {
                            HStack {
                                Text("회의 추가")
                                    .font(.system(size: 35, weight: .semibold, design: .default))
                                    .padding()
                                Spacer()
                            }
                            HStack {
                                Text("회의 주제 : ")
                                    .padding()
                                TextField("회의 주제를 입력해주세요!", text: $meetingTitle)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(1)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .autocapitalization(.none)
                                    .disableAutocorrection(false)
                                    .keyboardType(.webSearch)
                            }
                            
                            DatePicker(
                                "Select Date and Time",
                                selection: $selectedDate,
                                displayedComponents: [.date, .hourAndMinute]
                            )
                            .environment(\.locale, .init(identifier: "ko_KR"))
                            .datePickerStyle(.graphical)
                            .labelsHidden()
                            .padding()
                            
                        }
                        
                        Spacer()
                        
                        Button("저장") {
                            let newMeeting = Meeting(title: meetingTitle, date: selectedDate)
                            meetings.append(newMeeting)
                            
                            // MARK: - 추가 함수 호출
                            manager.scheduleNotification(for: newMeeting)
                            
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        .padding()
                    }
                    .navigationBarItems(trailing: Button("취소") {
                        self.presentationMode.wrappedValue.dismiss()
                    })
                }
            }
        }
    }
}

#Preview {
    AddMeetingView(meetings: .constant([Meeting(id: UUID(), title: "", date: Date())]))
}
