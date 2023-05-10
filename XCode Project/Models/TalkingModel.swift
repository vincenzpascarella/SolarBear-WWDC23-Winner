//
//  TalkingModel.swift
//  SolarBear
//
//  Created by Vincenzo Pascarella on 14/04/23.
//

import Foundation

struct TalkingModel {
    
    /// The texts array for displaying in the onboarding screen.
    let onboardingTexts = [
        "Hi, I’m Breesy the polar bear.",
        "I am here to guide you in exploring the North Pole and understanding how it is changing due to the impact of global warming on its ecosystem.",
        "But before we start, I need your help to wear my mask and become a superhero, the SolarBear."
    ]
    
    /// The texts array for displaying in the start game screen.
    let startGameTexts = [
        "Thank you for helping me wear my mask.",
        "I'm a superhero now.",
        "Together we will now start experiencing how the North Pole’s environment changes based on the main actors of global warming.",
        "Let's get started!"
    ]
    
    /// Indicates whether the onboarding process has started or not.
    var isStarted = false
    
    /// Indicates whether the shadow scaling animation is in progress.
    var shadowScaling = false
    
    /// Indicates whether the tap animation is in progress.
    var tapAnimation = false
    
    /// The index of the selected text in the `texts` array.
    var selectedText = 0
    
    /// Indicates whether the app is in the onboarding process or not.
    var isOnboarding = false
}
