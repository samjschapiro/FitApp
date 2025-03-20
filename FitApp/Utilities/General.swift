//
//  General.swift
//  FitApp
//
//  Created by Matthew Finkel on 3/12/25.
//

import UIKit

func triggerHapticFeedbackLight() {
    let generator = UIImpactFeedbackGenerator(style: .light) // ✅ Options: .light, .medium, .heavy
    generator.impactOccurred()
}


func triggerHapticFeedbackMedium() {
    let generator = UIImpactFeedbackGenerator(style: .medium) // ✅ Options: .light, .medium, .heavy
    generator.impactOccurred()
}
