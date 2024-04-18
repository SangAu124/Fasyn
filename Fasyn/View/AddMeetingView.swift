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
    
    var body: some View {
        NavigationView {
            ScrollViewReader { proxy in
                ScrollView(showsIndicators: false) {
                    VStack {
                        VStack {
                            HStack {
                                Text("Add Meeting")
                                    .font(.system(size: 35, weight: .semibold, design: .default))
                                    .padding()
                                Spacer()
                            }
                            HStack {
                                Text("Meeting Title : ")
                                    .padding()
                                TextField("your meetint title", text: $meetingTitle)
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
                        
                        Button("Save") {
                            let newMeeting = Meeting(title: meetingTitle, date: selectedDate)
                            meetings.append(newMeeting)
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        .padding()
                    }
                    .navigationBarItems(trailing: Button("Cancel") {
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
