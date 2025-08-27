import SwiftUI
import PostHog

struct HomeView: View {
    @State private var selectedDate = Date()
    
    private var displayDateText: Text {
        let today = Calendar.current.startOfDay(for: Date())
        let selected = Calendar.current.startOfDay(for: selectedDate)
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        if selected == today {
            return Text("TODAY")
        } else if selected == tomorrow {
            return Text("TOMORROW")
        } else if selected == yesterday {
            return Text("YESTERDAY")
        } else {
            return Text(formatter.string(from: selectedDate).uppercased())
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    WeekCalendarView(selectedDate: $selectedDate)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 20)
                    
                    WorkoutSessionView(selectedDate: $selectedDate)
                }
            }
            .navigationTitle(displayDateText)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView()){
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.primary)}
                    }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        selectedDate = Date()
                        PostHogSDK.shared.capture("Test Event")
                    }) {
                        Image(systemName: "house.fill")
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
}

struct WeekCalendarView: View {
    @Binding var selectedDate: Date
    private let calendar = Calendar.current
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }()
    
    private var weekDays: [Date] {
        guard let weekInterval = calendar.dateInterval(of: .weekOfYear, for: selectedDate) else {
            return []
        }
        var days: [Date] = []
        var date = weekInterval.start
        for _ in 0..<7 {
            days.append(date)
            date = calendar.date(byAdding: .day, value: 1, to: date) ?? date
        }
        return days
    }
    
    var body: some View {
            HStack(spacing: 0) {
                ForEach(weekDays, id: \.self) { date in
                    Button(action: {
                        selectedDate = date
                    }) {
                        VStack(spacing: 4) {
                            Text(dayLetter(for: date))
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            ZStack {
                                Circle()
                                    .fill(calendar.isDate(date, inSameDayAs: selectedDate) ? Color.blue : Color.clear)
                                    .frame(width: 32, height: 32)
                                
                                Text(dateFormatter.string(from: date))
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(calendar.isDate(date, inSameDayAs: selectedDate) ? .white : .primary)
                            }
                            
                            Circle()
                                .fill(hasWorkout(date) ? Color.blue : Color.clear)
                                .frame(width: 4, height: 4)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.plain)
            }
            .gesture(
                DragGesture()
                    .onEnded { value in
                        if abs(value.translation.width) > 50 {
                            PostHogSDK.shared.capture("Test Event")
                            if value.translation.width < 0 {
                                // Swipe left - move forward one week
                                if let newDate = calendar.date(byAdding: .weekOfYear, value: 1, to: selectedDate) {
                                    print(value.translation.width)
                                    selectedDate = newDate
                                }
                            } else if value.translation.width > 0 {
                                // Swipe right - move back one week
                                if let newDate = calendar.date(byAdding: .weekOfYear, value: -1, to: selectedDate) {
                                    print(value.translation.width)
                                    selectedDate = newDate
                                }
                            }
                        }
                    }
            )
        Divider()
        }
    
    private func dayLetter(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return String(formatter.string(from: date).prefix(1))
    }
    
    private func isToday(_ date: Date) -> Bool {
        calendar.isDate(date, inSameDayAs: Date())
    }
    
    private func hasWorkout(_ date: Date) -> Bool {
        return calendar.isDate(date, inSameDayAs: Date()) ||
               calendar.isDate(date, inSameDayAs: calendar.date(byAdding: .day, value: 2, to: Date()) ?? Date())
    }
}

struct WorkoutSessionView: View {
    @Binding var selectedDate: Date

    var body: some View {
        VStack(spacing: 0) {
            NavigationLink(destination: WorkoutView()) {
                    Text("Start Session")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 20)

            
            LazyVStack(spacing: 20) {
                WorkoutSection(
                    title: "CONDITIONING",
                    exercises: [
                        Exercise(id: "A", name: "Cardio", details: "1 x 12:00")
                    ]
                )
                
                WorkoutSection(
                    title: "WARM UP",
                    exercises: [
                        Exercise(id: "B1", name: "Push Up", details: "3 x 15"),
                        Exercise(id: "B2", name: "Plank Hold", details: "3 x 30 s"),
                        Exercise(id: "B3", name: "Lunge Twist", details: "3 x 10")
                    ]
                )
                
                WorkoutSection(
                    title: "FOUNDATION WORK",
                    exercises: [
                        Exercise(id: "C", name: "Barbell Press", details: "3 x 5", hasWeight: true)
                    ]
                )
                
                WorkoutSection(
                    title: "MELT DOWN",
                    exercises: [
                        Exercise(id: "D1", name: "Lateral Plyo Skiers", details: "4 x 12"),
                        Exercise(id: "D2", name: "Tea Pot Walking Lunge", details: "4 x 6"),
                        Exercise(id: "D3", name: "Russian Twists", details: "4 x 20")
                    ]
                )
            }
            
            Spacer(minLength: 100)
        }
        .gesture(
            DragGesture()
                .onEnded { value in
                    if abs(value.translation.width) > 50 {
                        if value.translation.width < 0 {
                            // Swipe left - move forward one day __BROKEN__
                            if let newDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate) {
                                selectedDate = newDate
                                print(value.translation.width)

                            }
                        } else if value.translation.width > 0 {
                            // Swipe right - move back one day __WORKING__
                            if let newDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate) {
                                selectedDate = newDate
                                print(value.translation.width)
                            }
                        }
                    }
                }
        )
    }
}

struct WorkoutSection: View {
    let title: String
    let exercises: [Exercise]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                Spacer()
            }
            .padding(.horizontal, 16)
            
            ForEach(exercises) { exercise in
                ExerciseRow(exercise: exercise)
            }
        }
    }
}

struct ExerciseRow: View {
    let exercise: Exercise
    
    var body: some View {
        HStack(spacing: 12) {
            Text(exercise.id)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .frame(width: 30, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    if exercise.hasWeight {
                        Image(systemName: "scalemass")
                            .foregroundColor(.blue)
                            .font(.caption)
                        Text("For Weight")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                }
                
                Text(exercise.name)
                    .font(.body)
                    .fontWeight(.medium)
                
                Text(exercise.details)
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .fontWeight(.medium)
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

struct Exercise: Identifiable {
    let id: String
    let name: String
    let details: String
    let hasWeight: Bool
    
    init(id: String, name: String, details: String, hasWeight: Bool = false) {
        self.id = id
        self.name = name
        self.details = details
        self.hasWeight = hasWeight
    }
}

#Preview{
    HomeView()
}
