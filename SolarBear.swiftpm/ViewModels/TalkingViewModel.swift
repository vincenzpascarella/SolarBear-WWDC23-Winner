//
//  TalkingViewModel.swift
//  SolarBear
//
//  Created by Vincenzo Pascarella on 14/04/23.
//

import AVFoundation
import SwiftUI

extension TalkingView{
    
    /// The view model for the onboarding screen.
    class TalkingViewModel: ObservableObject {
        
        @Published private var model = TalkingModel()
        
        /// Indicates whether to navigate to the next view or not.
        @Published var goToNextView = false
        
        private var backgroundSound: AVAudioPlayer?
        
        /// The array of texts to display depending on whether the onboarding process has started or the game has started.
        private var texts: [String] {
            if isOnboarding {
                return model.onboardingTexts
            } else {
                return model.startGameTexts
            }
        }
        
        /// Indicates whether the onboarding process has started or not.
        var isStarted: Bool {
            model.isStarted
        }
        
        /// Indicates whether the shadow scaling animation is in progress.
        var shadowScaling: Bool {
            get { model.shadowScaling }
            set { model.shadowScaling = newValue }
        }
        
        /// Indicates whether the tap animation is in progress.
        var tapAnimation: Bool {
            get { model.tapAnimation }
            set { model.tapAnimation = newValue }
        }
        
        /// This computed property indicates whether the app is currently in onboarding mode or not. It gets the value from the `isOnboarding` property of the `model` struct, and can be set by assigning a new value to it.
        var isOnboarding: Bool {
            get { model.isOnboarding }
            set { model.isOnboarding = newValue }
        }
        
        /// The text to display on the onboarding screen.
        /// This is the text at the index specified by the `selectedText` property of the `OnboardingViewModel`.
        var textToDisplay: String {
            texts[model.selectedText]
        }
        
        /// Use this function to start playing the music
        func startMusic() {
            if let audioURL = Bundle.main.url(forResource: "BackgroundMusic", withExtension: "mp3") {
                do {
                    try backgroundSound = AVAudioPlayer(contentsOf: audioURL)
                    backgroundSound?.numberOfLoops = .max
                    backgroundSound?.play()
                    backgroundSound?.setVolume(0.01, fadeDuration: 0)
                } catch {
                    print("Couldn't play audio. Error: \(error)")
                }
            }else {
                print("No audio file found")
            }
        }
                
        /// Handles the tap gesture of the onboarding screen
        ///
        /// This method is called when the user taps on the screen. It manages the tap animation and text display logic based on the current state of the onboarding screen.
        func tapGestureAnimation() {
            if shouldIncrementSelectedText() {
                incrementSelectedTextIndex()
            } else if shouldNavigateToNextView() {
                navigateToNextView()
            } else {
                startOnboarding()
            }
            
            startTapAnimation()
            
            // Play a system sound to indicate the tap gesture.
            AudioServicesPlaySystemSound(1103)
        }
        
        /// Returns a Boolean value indicating whether the selected text can be incremented
        private func shouldIncrementSelectedText() -> Bool {
            return isStarted && (model.selectedText < texts.count - 1)
        }
        
        /// Increments the selected text index by 1
        private func incrementSelectedTextIndex() {
            withAnimation {
                model.selectedText += 1
            }
        }
        
        /// Returns a Boolean value indicating whether the next view should be navigated to
        private func shouldNavigateToNextView() -> Bool {
            return model.selectedText >= texts.count - 1
        }
        
        /// Toggles the variable to navigate to the next view.
        private func navigateToNextView() {
            withAnimation {
                goToNextView.toggle()
            }
        }
        
        /// Starts the onboarding
        private func startOnboarding() {
            withAnimation() {
                model.isStarted = true
            }
        }
        
        /// Starts the tap animation
        private func startTapAnimation() {
            model.tapAnimation = false
            withAnimation(.easeInOut(duration: 1).delay(4).repeatForever(autoreverses: true)) {
                model.tapAnimation.toggle()
            }
        }
        
    }
    
}
