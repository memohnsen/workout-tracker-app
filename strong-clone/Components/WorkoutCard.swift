//
//  WorkoutCard.swift
//  strong-clone
//
//  Created by Maddisen Mohnsen on 8/24/25.
//

import SwiftUI

struct WorkoutCard: View {
    let title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title).font(.headline)
            
            Spacer()
        }
        .frame(height: 100)
        .frame(width: 140)
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    }
}

#Preview {
    ContentView()
}
