//
//  MetricsView.swift
//  strong-clone
//
//  Created by Maddisen Mohnsen on 8/24/25.
//

import SwiftUI
import Charts

struct Metric: Identifiable {
    let id = UUID()
    let date: String
    let lift: String
    let e1rm: Double
}

let sampleData = [
    Metric(date: "2025-08-04", lift: "Squat", e1rm: 330),
    Metric(date: "2025-08-14", lift: "Squat", e1rm: 300),
    Metric(date: "2025-08-24", lift: "Squat", e1rm: 350)
]

struct MetricsView: View {
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2).ignoresSafeArea()
            
            ScrollView{
                VStack(alignment: .leading) {
                    Text("Metrics")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, 8)
                                        
                    VStack(alignment: .center) {
                        Text("Squat").font(.title)
                            .padding(.top, 8)
                        Chart(sampleData) { metric in
                            LineMark(
                                x: .value("Date", metric.date),
                                y: .value("1 Rep Max", metric.e1rm)
                            )
                        }
                        .frame(height: 200)
                        .padding()
                    }
                    .background(Color.white)
                    .frame(width: 350)
                    .cornerRadius(12)
                }
            }
        }
    }
}

#Preview {
    MetricsView()
}
