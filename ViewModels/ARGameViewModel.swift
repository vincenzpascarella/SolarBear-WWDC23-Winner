//
//  ARGameViewModel.swift
//  SolarBear
//
//  Created by Vincenzo Pascarella on 19/04/23.
//

import SwiftUI
import AVFoundation

extension ARGameView {
    
    class ARGameViewModel: ObservableObject {
        
        @Published private var model = ARGameModel()
        
        /// The array of buttons available in the game screen.
        var buttons: [ARGameModel.Button] {
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
        
        /// Toggles the tapped state of the provided button.
        func toggle(_ tappedButton: ARGameModel.Button){
            
            var newTappedButtons = buttons
            
            guard let index = newTappedButtons.firstIndex(where: {$0.id == tappedButton.id}) else { return }
            
            newTappedButtons[index].isTapped.toggle()
            
            buttons = newTappedButtons
            
            // Play a system sound to indicate the tap gesture.
            AudioServicesPlaySystemSound(1103)
        }
        
    }
    
}
