//
//  DetailMeetingView.swift
//  Fasyn
//
//  Created by 김상금 on 4/17/24.
//

import SwiftUI

struct MeetingDetailView: View {
    var meeting: Meeting
    
    var body: some View {
        VStack {
            Text(meeting.title)
                .font(.title)
                .padding()
            Spacer()
        }
        .navigationBarTitle("Meeting Detail")
    }
}

#Preview {
    MeetingDetailView(meeting: Meeting(title: "testtest", date: Date()))
}
