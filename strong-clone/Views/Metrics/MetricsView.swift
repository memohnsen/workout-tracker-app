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

let benchPress = [
    Metric(date: "2025-8-04", lift: "Bench Press", e1rm: 200),
    Metric(date: "2025-08-14", lift: "Bench Press", e1rm: 215),
]

struct MetricsView: View {
    fileprivate func rmGraph(data: [Metric]) -> some View {
        return VStack(alignment: .center) {
            Text(data.first?.lift ?? "").font(.title)
                .padding(.top, 8)
            Chart(data) { metric in
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
        .padding(.bottom, 8)
    }
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2).ignoresSafeArea()
            
            ScrollView{
                VStack(alignment: .leading) {
                    Text("Metrics")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, 8)
                                        
                    rmGraph(data: sampleData)
                    rmGraph(data: benchPress)
                
                }
            }
        }
    }
}

#Preview {
    MetricsView()
}
