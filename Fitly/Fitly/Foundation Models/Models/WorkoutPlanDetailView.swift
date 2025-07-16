import SwiftUI
import FoundationModels

struct WorkoutPlanDetailView: View {
    let plan: WorkoutPlan2
    
    // For preview/sample usage: image asset or system image
    var headerImage: Image {
        // Replace with AsyncImage(url:) if you restore imageURL in WorkoutPlan2
        Image("workout_sample")
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Header image with overlay
                ZStack(alignment: .bottom) {
                    headerImage
                        .resizable()
                        .aspectRatio(4/3, contentMode: .fill)
                        .frame(height: 260)
                        .clipped()
                        .cornerRadius(28)
                        .padding(.horizontal, 12)
                        .padding(.top, 12)
                    
                    HStack(spacing: 22) {
                        WorkoutPlanStatItem(icon: "timer", title: "Time", value: "\(plan.totalTimeMinutes) min")
                        WorkoutPlanStatItem(icon: "flame", title: "Burn", value: plan.estimatedCalorieBurn)
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .padding(.horizontal, 42)
                    .padding(.bottom, 10)
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    // Title
                    Text(plan.name)
                        .font(.system(.title2, weight: .bold))
                        .padding(.top, 18)
                        .padding(.horizontal, 20)
                    // Description
                    Text(plan.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 6)
                    
                    // Rounds/Sections header
                    HStack {
                        Text("Rounds")
                            .font(.headline)
                        Spacer()
                        if let roundsCount = plan.sections.first?.exercises.count {
                            Text("1/\(roundsCount)")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    // Exercises list (show first section only for now)
                    VStack(spacing: 14) {
                        ForEach(Array(plan.sections.first?.exercises.prefix(8) ?? []), id: \.name) { ex in
                            WorkoutExerciseRow(exercise: ex)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.bottom, 20)
                    
                    // Lets Workout button
                    Button(action: { /* Start workout action */ }) {
                        Text("Lets Workout")
                            .font(.headline)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }
                    .padding(.horizontal, 14)
                    .padding(.bottom, 28)
                }
            }
        }
        .background(Color(.systemGray6).ignoresSafeArea())
        .navigationTitle("Workout")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct WorkoutPlanStatItem: View {
    let icon: String
    let title: String
    let value: String
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .foregroundColor(.blue)
            Text(title)
                .font(.caption2)
            Text(value)
                .font(.subheadline).bold()
                .foregroundColor(.cyan)
        }
        .frame(minWidth: 66)
    }
}

struct WorkoutExerciseRow: View {
    let exercise: WorkoutExercise2
    var body: some View {
        HStack(spacing: 14) {
            // Placeholder for exercise image; replace with AsyncImage if available
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.secondary.opacity(0.3))
                .frame(width: 56, height: 56)
                .overlay(
                    Image(systemName: "figure.strengthtraining.traditional")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.blue)
                )
            VStack(alignment: .leading, spacing: 3) {
                Text(exercise.name)
                    .font(.headline)
                Text(exercise.repetitionsOrDuration)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            Button(action: { /* Play action */ }) {
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .foregroundColor(.blue)
            }
        }
        .padding(8)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
    }
}

// MARK: - Preview with mock data
#if DEBUG
struct WorkoutPlanDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sample = WorkoutPlan2(
            name: "Lower Body Training",
            totalTimeMinutes: 20,
            estimatedCalorieBurn: "95 kcal",
            equipmentRequired: ["Mat"],
            description: "The lower abdomen and hips are the most difficult areas of the body to reduce when we are on a diet. Even so, in this area, especially the legs as a whole, you can reduce weight even if you don't use tools.",
            sections: [
                WorkoutSection2(
                    title: "Main",
                    sectionDescription: "Legs focus.",
                    exercises: [
                        WorkoutExercise2(
                            name: "Jumping Jacks",
                            setsOrRounds: 1,
                            repetitionsOrDuration: "00:30",
                            level: "Beginner",
                            benefits: ["Warmup", "Cardio"],
                            instructions: "Jump legs out and arms overhead.",
                            targetBodyParts: ["Legs", "Core"]
                        ),
                        WorkoutExercise2(
                            name: "Squats",
                            setsOrRounds: 1,
                            repetitionsOrDuration: "12 reps",
                            level: "Beginner",
                            benefits: ["Strength"],
                            instructions: "Lower hips down and up.",
                            targetBodyParts: ["Legs"]
                        ),
                        WorkoutExercise2(
                            name: "Backward Lunge",
                            setsOrRounds: 1,
                            repetitionsOrDuration: "12 reps",
                            level: "Intermediate",
                            benefits: ["Balance"],
                            instructions: "Step backward into lunge.",
                            targetBodyParts: ["Legs"]
                        )
                    ]
                )
            ]
        )
        NavigationStack {
            WorkoutPlanDetailView(plan: sample)
        }
    }
}
#endif
