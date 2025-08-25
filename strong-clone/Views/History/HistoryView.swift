//
//  HistoryView.swift
//  strong-clone
//
//  Created by Maddisen Mohnsen on 8/24/25.
//

import SwiftUI

struct HistoryView: View {
    var daysCompleted: [String] = ["2025-08-24", "2025-08-23", "2025-08-22"]
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2)
                .ignoresSafeArea()
            
            List{
                ForEach(daysCompleted, id:\.self) { day in
                    HStack {
                        Text(day)
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.green)
                        Image(systemName: "chevron.right")
                    }
                }
            }
        }
    }
}

#Preview {
    HistoryView()
}
