//
//  GameViewModel.swift
//  SolarBear
//
//  Created by Vincenzo Pascarella on 17/04/23.
//

import SwiftUI
import Combine
import AVFoundation

extension GameView {
    
    class GameViewModel: ObservableObject {
        
        @Published private var model = GameModel()
        
        /// The index of the current instruction being shown by the bear.
        @Published private var showedInstruction = 0
        
        /// Indicates whether to navigate to the next view or not.
        @Published var goToAR = false
        
        /// The timer used to animate the bear's instructions.
        @Published private var timer: AnyCancellable?
        
        /// The array of buttons available in the game screen.
        var buttons: [GameModel.Button] {
            get { model.buttons }
            set { model.buttons = newValue }
        }
        
        /// The number of buttons that have been tapped by the user.
        var tappedButtonsCount: Int {
            model.buttons.filter({ $0.isTapped }).count
        }
        
        /// The current iceberg being displayed.
        var iceberg: String {
            model.icebergs[tappedButtonsCount]
        }
        
        /// The current bear instruction being displayed.
        var bearInstruction: String {
            model.bearInstruction[showedInstruction]
        }
        
        /// Toggles the tapped state of the provided button.
        func toggle(_ tappedButton: GameModel.Button){
            
            var newTappedButtons = buttons
            
            guard let index = newTappedButtons.firstIndex(where: {$0.id == tappedButton.id}) else { return }
            
            newTappedButtons[index].isTapped.toggle()
            
            buttons = newTappedButtons
            
            // Play a system sound to indicate the tap gesture.
            AudioServicesPlaySystemSound(1103)
        }
        
        /// Starts the animation of the bear's instructions.
        func startInstructionAnimation() {
            timer = Timer.publish(every: 3, on: .main, in: .common)
                .autoconnect()
                .sink { _ in
                    withAnimation(.easeInOut(duration: 0.5)) {
                        self.bearInstructionAnimation()
                    }
                }
        }
        
        /// Stops the animation of the bear's instructions.
        func stopInstructionAnimation() {
            timer?.cancel()
        }
        
        /// Advances the index of the current instruction being shown by the bear.
        private func bearInstructionAnimation() {
            if showedInstruction < model.bearInstruction.count - 1 {
                showedInstruction += 1
            } else {
                showedInstruction = 0
            }
        }
        
    }
    
}
