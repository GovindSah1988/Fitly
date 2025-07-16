//
//  UserProfile.swift
//  Fitly
//
//  Created by Jigneshkumar Gangajaliya on 13/07/25.
//

import SwiftData

@Model
class UserProfile {
    var gender: String
    var age: String
    var weight: String
    var height: String
    var weightUnit: String
    var heightUnit: String
    var goal: String

    init(gender: String, age: String, weight: String, height: String, weightUnit: String, heightUnit: String, goal: String) {
        self.gender = gender
        self.age = age
        self.weight = weight
        self.height = height
        self.weightUnit = weightUnit
        self.heightUnit = heightUnit
        self.goal = goal
    }
}
