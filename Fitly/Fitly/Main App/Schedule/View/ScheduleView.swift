//
//  ScheduleView.swift
//  Fitly
//
//  Created by Jigneshkumar Gangajaliya on 16/07/25.
//

import SwiftUI
import Combine

class WeekCalendarViewModel: ObservableObject {
    @Published var days: [Day] = []

    init() {
        appendWeek(from: Date())
    }

    func appendWeek(from startDate: Date) {
        guard let startOfWeek = Calendar.current.dateInterval(of: .weekOfYear, for: startDate)?.start else { return }

        for i in 0..<7 {
            if let day = Calendar.current.date(byAdding: .day, value: i, to: startOfWeek) {
                days.append(Day(date: day))
            }
        }
    }

    func loadNextWeek() {
        if let lastDate = days.last?.date,
           let nextWeekStart = Calendar.current.date(byAdding: .day, value: 1, to: lastDate) {
            appendWeek(from: nextWeekStart)
        }
    }
}

struct Day: Identifiable, Equatable {
    let id = UUID()
    let date: Date
    var dayNumber: Int { Calendar.current.component(.day, from: date) }
    var weekday: String {
        let symbol = Calendar.current.shortWeekdaySymbols[
            Calendar.current.component(.weekday, from: date) - 1
        ]
        return String(symbol.prefix(1))
    }
}

import SwiftUI

// MARK: - Model
struct Week: Identifiable {
    let id = UUID()
    let days: [Date]

    init(startingFrom date: Date) {
        let calendar = Calendar.current
        let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: date)?.start ?? date
        days = (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek) }
    }
}

// MARK: - ViewModel
class WeekPaginationViewModel: ObservableObject {
    @Published var weeks: [Week] = []

    init() {
        let current = Date()
        weeks = [Week(startingFrom: current)]
    }

    func loadNextWeekIfNeeded(currentIndex: Int) {
        if currentIndex == weeks.count - 1 {
            if let lastDate = weeks.last?.days.last,
               let nextWeekStart = Calendar.current.date(byAdding: .day, value: 1, to: lastDate) {
                weeks.append(Week(startingFrom: nextWeekStart))
            }
        }
    }
}

struct DayCellView: View {
    let date: Date
    let selectedDate: Date

    var body: some View {
        VStack {
            VStack(spacing: 4) {
                Text(daySymbol(for: date))
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text("\(Calendar.current.component(.day, from: date))")
                    .font(.headline)
            }
            .padding(12)
            .background(
                Calendar.current.isDate(date, inSameDayAs: selectedDate)
                ? Color.gray.opacity(0.4)
                : Color.blue
            )
            .foregroundColor(.primary)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Spacer(minLength: 8)
            if Calendar.current.isDateInToday(date) {
                Circle()
                    .fill(Color.black)
                    .frame(width: 6, height: 6)
            } else {
                EmptyView()
            }
        }
    }

    func daySymbol(for date: Date) -> String {
        let index = Calendar.current.component(.weekday, from: date) - 1
        return String(Calendar.current.shortWeekdaySymbols[index].prefix(1))
    }
}

struct WeekRowView: View {
    let week: Week
    @Binding var selectedDate: Date

    var body: some View {
        HStack(spacing: 12) {
            ForEach(week.days, id: \.self) { date in
                DayCellView(date: date, selectedDate: selectedDate)
                    .frame(width: 46, height: 46)
                    .onTapGesture {
                        selectedDate = date
                    }
            }
        }
    }
}

struct ScheduleView: View {
    @StateObject private var viewModel = WeekPaginationViewModel()
    @State private var currentIndex = 0
    @State private var selectedDate = Date()

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(monthYearString(from: selectedDate))
                    .font(.title2)
                    .bold()
                    .padding(.leading)
                
                TabView(selection: $currentIndex) {
                    ForEach(Array(viewModel.weeks.enumerated()), id: \.1.id) { index, week in
                        WeekRowView(week: week, selectedDate: $selectedDate)
                            .tag(index)
                            .onAppear {
                                viewModel.loadNextWeekIfNeeded(currentIndex: index)
                            }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(height: 80) // Adjust height based on cell size
            }
            Spacer()
        }
    }

    // Helper to format month/year
    func monthYearString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL yyyy"
        return formatter.string(from: date)
    }
}


#Preview {
    ScheduleView()
}
