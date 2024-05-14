//
//  ContentView.swift
//  Fasyn
//
//  Created by 김상금 on 4/17/24.
//

import SwiftUI

struct ContentView: View {
    @State private var meetings: [Meeting] = []
    @State private var isPresentingAddMeetingView = false
    @State private var isEditing = false
    let dateFormatter = DateFormatter()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("회의 리스트")
                        .font(.system(size: 35, weight: .semibold, design: .default))
                        .padding()
                    Spacer()
                }
                
                List {
                    ForEach(meetings, id: \.id) { meeting in
                        NavigationLink(destination: MeetingDetailView(meeting: meeting)) {
                            MeetingCellView(meeting: meeting)
                                .foregroundColor(.black)
                        }
                    }
                    .onDelete(perform: deleteMeeting)
                }
                
                Button(action: {
                    isPresentingAddMeetingView.toggle()
                }) {
                    Text("회의 추가")
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
            }
            .navigationBarItems(
                leading: isEditing ? Button(action: {
                    isEditing.toggle()
                }) {
                    Text("완료")
                } : nil,
                trailing: isEditing ? nil : Button(action: {
                    isEditing.toggle()
                }) {
                    Text("편집")
                }
            )
            .sheet(isPresented: $isPresentingAddMeetingView) {
                AddMeetingView(meetings: $meetings)
            }
            .environment(\.editMode, .constant(isEditing ? EditMode.active : EditMode.inactive))
        }
    }
    
    private func setDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy년 M월 d일 a h시 m분"
        dateFormatter.locale = Locale(identifier:"ko_KR")
        let convertStr = dateFormatter.string(from: date)
        return convertStr
    }
    
    private func deleteMeeting(at offsets: IndexSet) {
        meetings.remove(atOffsets: offsets)
    }
}


#Preview {
    ContentView()
}
