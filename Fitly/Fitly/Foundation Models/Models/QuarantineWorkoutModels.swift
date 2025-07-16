//  QuarantineWorkoutModels.swift
//  Fitly
//
//  Created for quarantine workout plan requests.

import Foundation
import FoundationModels

// MARK: - Quarantine Workout Request

@Generable
struct QuarantineWorkoutRequest: Codable, Equatable {
    @Guide(description: "The biological sex of the individual.")
    var gender: Gender
    
    @Guide(.range(18...80))
    var age: Int
    
    @Guide(.range(30.0...180.0))
    var bodyWeightKg: Double
    
    @Guide(description: "Current fitness level, e.g. beginner, intermediate, advanced.")
    var fitnessLevel: FitnessLevel
    
    @Guide(description: "Any available equipment, e.g. none, dumbbells, resistance bands, mat, etc.")
    var availableEquipment: [String]?
    
    @Guide(description: "Any injuries or conditions that should be considered (optional)")
    var injuriesOrConditions: String?
    
    @Guide(description: "The goal for this quarantine workout (e.g., maintain health, build strength, lose fat, improve mood, etc.)")
    var goal: String?
}

@Generable
enum Gender: String, Codable, Equatable {
    case male, female, other
}

@Generable
enum FitnessLevel: String, Codable, Equatable {
    case beginner, intermediate, advanced
}

// You can further extend this as needed for more fields.

