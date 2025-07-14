import SwiftUI

struct WorkoutPlanView: View {
    @State private var viewModel: WorkoutPlanViewModel
    let prompt: String

    init(prompt: String, useCase: GenerateWorkoutPlanUseCase) {
        self.prompt = prompt
        _viewModel = State(initialValue: WorkoutPlanViewModel(prompt: prompt, useCase: useCase))
    }

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Generating workout plan...")
                        .padding()
                } else if let plan = viewModel.workoutPlan {
                    WorkoutPlanContentView(plan: plan)
                } else if let error = viewModel.error {
                    VStack(spacing: 16) {
                        Label(error, systemImage: "exclamationmark.triangle")
                        Button("Try Again") {
                            Task { await viewModel.generatePlan() }
                        }
                    }
                } else {
                    Button(action: { Task { await viewModel.generatePlan() } }) {
                        Label("Generate Workout Plan", systemImage: "figure.strengthtraining.functional")
                            .font(.title2).padding()
                    }
                }
            }
            .navigationTitle("Weekly Workout Plan")
            .toolbar { ToolbarItem(placement: .navigationBarTrailing) { Button("Refresh") { Task { await viewModel.generatePlan() } } } }
        }
    }
}

struct WorkoutPlanContentView: View {
    let plan: WorkoutPlan
    @State private var expandedDay: Int? = 0

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                ForEach(Array(plan.days.enumerated()), id: \.offset) { idx, day in
                    WorkoutDayCard(day: day, isExpanded: expandedDay == idx) {
                        withAnimation { expandedDay = expandedDay == idx ? nil : idx }
                    }
                }
                Divider().padding(.top, 8)
                WorkoutTipsSection(tips: plan.tips)
            }
            .padding()
        }
    }
}

struct WorkoutDayCard: View {
    let day: WorkoutDay
    let isExpanded: Bool
    let onTap: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Button(action: onTap) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(day.title)
                            .font(.headline)
                        if let warmUp = day.warmUp {
                            Text("Warm-up: \(warmUp)")
                                .font(.subheadline).foregroundStyle(.secondary)
                        }
                        if let notes = day.notes {
                            Text(notes)
                                .font(.subheadline).italic().foregroundStyle(.secondary)
                        }
                    }
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.accentColor)
                }
                .padding()
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            }
            if isExpanded {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(Array(day.activities.enumerated()), id: \.offset) { _, activity in
                        WorkoutActivityRow(activity: activity)
                    }
                }
                .padding([.horizontal, .bottom])
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(LinearGradient(colors: [.blue.opacity(0.12), .teal.opacity(0.05)], startPoint: .top, endPoint: .bottom))
        )
        .padding(.horizontal)
        .shadow(color: .black.opacity(0.04), radius: 4, x: 0, y: 1)
    }
}

struct WorkoutActivityRow: View {
    let activity: WorkoutActivity
    var body: some View {
        switch activity {
        case .exercise(let ex):
            HStack(alignment: .top, spacing: 8) {
                Image(systemName: "figure.strengthtraining.traditional")
                VStack(alignment: .leading) {
                    Text(ex.name).bold()
                    HStack(spacing: 16) {
                        if let sets = ex.sets { Text("Sets: \(sets)") }
                        if let reps = ex.reps { Text(reps) }
                        if let duration = ex.duration { Text("\(duration)") }
                    }.font(.caption)
                    if let notes = ex.notes { Text(notes).font(.caption2).italic().foregroundStyle(.secondary) }
                }
            }
        case .cardio(let c):
            HStack(alignment: .top, spacing: 8) {
                Image(systemName: "figure.run")
                VStack(alignment: .leading) {
                    Text("Cardio").bold()
                    Text(c.description)
                    if let dur = c.duration { Text("Duration: \(dur)").font(.caption) }
                }
            }
        case .flexibility(let f):
            HStack(alignment: .top, spacing: 8) {
                Image(systemName: "figure.yoga")
                VStack(alignment: .leading) {
                    Text("Flexibility / Mobility").bold()
                    Text(f.description)
                    if let dur = f.duration { Text("Duration: \(dur)").font(.caption) }
                }
            }
        case .recovery(let r):
            HStack(alignment: .top, spacing: 8) {
                Image(systemName: "figure.walk")
                VStack(alignment: .leading) {
                    Text("Recovery / Light Activity").bold()
                    Text(r.description)
                    if let dur = r.duration { Text("Duration: \(dur)").font(.caption) }
                }
            }
        }
    }
}

struct WorkoutTipsSection: View {
    let tips: [WorkoutTip]
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Tips for Success", systemImage: "lightbulb.fill")
                .font(.title3).bold()
                .foregroundStyle(.yellow)
            ForEach(tips, id: \.category) { tip in
                HStack(alignment: .top, spacing: 8) {
                    Image(systemName: icon(for: tip.category))
                        .foregroundStyle(.teal)
                    VStack(alignment: .leading) {
                        Text(tip.category).bold()
                        Text(tip.text)
                            .font(.callout)
                    }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.ultraThickMaterial)
        )
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
    func icon(for category: String) -> String {
        switch category.lowercased() {
        case "nutrition": return "fork.knife"
        case "hydration": return "drop.fill"
        case "sleep": return "bed.double.fill"
        case "monitor progress": return "chart.bar.fill"
        default: return "lightbulb"
        }
    }
}

#Preview {
    WorkoutPlanView(prompt: "Create a balanced weekly workout", useCase: MockGenerateWorkoutPlanUseCase())
}
