import SwiftUI

struct PopularWorkoutProgramCarouselView: View {
    let programs: [PopularWorkoutProgram]
    @State private var selectedIndex: Int = 0
    
    var body: some View {
        GeometryReader { geometry in
            TabView(selection: $selectedIndex) {
                ForEach(programs.indices, id: \.self) { idx in
                    PopularWorkoutProgramCardView(program: programs[idx])
                        .frame(width: geometry.size.width * 0.75, height: 320)
                        .scaleEffect(selectedIndex == idx ? 1.0 : 0.88)
                        .opacity(selectedIndex == idx ? 1 : 0.6)
                        .shadow(color: .black.opacity(selectedIndex == idx ? 0.18 : 0.04), radius: selectedIndex == idx ? 14 : 4, y: 6)
                        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: selectedIndex)
                        .padding(.vertical, 48)
                        .padding(.horizontal, 8)
                        .tag(idx)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(width: geometry.size.width, height: 370)
            .background(Color.clear)
        }
        .frame(height: 370)
        .overlay(
            HStack(spacing: 6) {
                ForEach(programs.indices, id: \.self) { i in
                    Circle()
                        .fill(i == selectedIndex ? Color.accentColor : Color.gray.opacity(0.28))
                        .frame(width: i == selectedIndex ? 10 : 7, height: i == selectedIndex ? 10 : 7)
                        .animation(.easeInOut, value: selectedIndex)
                }
            }
            .padding(.top, 10)
            , alignment: .top
        )
    }
}

struct PopularWorkoutProgramCardView: View {
    let program: PopularWorkoutProgram
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(program.name)
                .font(.headline)
            Text(program.type.rawValue.capitalized)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            if let desc = program.description {
                Text(desc)
                    .font(.footnote)
                    .foregroundStyle(.tertiary)
            }
            HStack {
                Label(program.duration, systemImage: "clock")
                if let calories = program.caloriesBurnedEstimate {
                    Label(calories, systemImage: "flame")
                }
            }
            .font(.caption)
            .foregroundStyle(.secondary)
            if !program.equipmentRequired.isEmpty {
                Text("Equipment: " + program.equipmentRequired.joined(separator: ", "))
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 4, y: 2)
    }
}

#Preview {
    let samples = [
        PopularWorkoutProgram(
            name: "Full-Body Strength Training",
            type: .strength,
            description: "A comprehensive strength-focused routine for all levels.",
            equipmentRequired: ["Dumbbells", "Mat"],
            duration: "45-60 minutes",
            plan: WorkoutStructure(
                warmUp: PlanSection(title: "Warm Up", activities: [.freeText("Jog in place for 3 minutes")], repeatCount: nil),
                mainSections: [
                    PlanSection(
                        title: "Main Circuit",
                        activities: [
                            .namedActivity(NamedActivity(name: "Burpees", reps: "12 reps", duration: "30 seconds", notes: "Explosive movement")),
                            .namedActivity(NamedActivity(name: "Push-Ups", reps: "15 reps", duration: nil, notes: nil))
                        ],
                        repeatCount: "Repeat 3 times"
                    )
                ],
                coolDown: PlanSection(title: "Cool Down", activities: [.freeText("Stretch for 5 minutes")], repeatCount: nil)
            ),
            caloriesBurnedEstimate: "300-400 calories",
            videoResources: [VideoResource(title: "Follow Along Video", url: "https://example.com/video", notes: "Optional video guide.")]
        ),
        PopularWorkoutProgram(
            name: "HIIT Express",
            type: .hiit,
            description: "Quick, intense intervals for max calorie burn.",
            equipmentRequired: ["Mat"],
            duration: "25 minutes",
            plan: WorkoutStructure(
                warmUp: PlanSection(title: "Warm Up", activities: [.freeText("Jumping Jacks - 2 min")], repeatCount: nil),
                mainSections: [
                    PlanSection(
                        title: "HIIT Circuit",
                        activities: [
                            .namedActivity(NamedActivity(name: "Mountain Climbers", reps: "30 reps", duration: "45 seconds", notes: nil)),
                            .freeText("Rest 15 seconds")
                        ],
                        repeatCount: "Repeat 4 times"
                    )
                ],
                coolDown: PlanSection(title: "Cool Down", activities: [.freeText("Stretch arms and legs")], repeatCount: nil)
            ),
            caloriesBurnedEstimate: "200-250 calories",
            videoResources: nil
        )
    ]
    PopularWorkoutProgramCarouselView(programs: samples)
}
