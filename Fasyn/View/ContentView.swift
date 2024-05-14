//
//  ContentView.swift
//  Fasyn
//
//  Created by 김상금 on 4/17/24.
//

import SwiftUI

struct ContentView: View {
    @State var meetings: [Meeting] = []
    @State private var isPresentingAddMeetingView = false
    @State private var isEditing = false
    let dateFormatter = DateFormatter()
    let defaults = UserDefaults.standard
    let meetingManager = MeetingsManager.shared
    
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
                    ForEach(meetingManager.loadMeetings(), id: \.id) { meeting in
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
                AddMeetingView()
            }
            .environment(\.editMode, .constant(isEditing ? EditMode.active : EditMode.inactive))
        }
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
        
    }
    
    private func deleteMeeting(at offsets: IndexSet) {
        if let index = offsets.first {
            let meetingToDelete = meetingManager.loadMeetings()[index]
            meetingManager.deleteMeeting(meetingToDelete)
        }
    }
}


#Preview {
    ContentView()
}
