//
//  ButtonsInstructionsViewModel.swift
//  SolarBear
//
//  Created by Vincenzo Pascarella on 16/04/23.
//

import Foundation
import AVFoundation

extension ButtonsInstructionsView {
    
    class ButtonsInstructionsViewModel: ObservableObject {
        
        @Published private var model = ButtonsInstructionsModel()
        
        /// Indicates whether to navigate to the next view or not.
        @Published var goToNextView = false
        
        /// An array containing the `InstructionStructure` elements to be displayed on the screen.
        var showedButtons: [ButtonsInstructionsModel.InstructionStructure] {
            get { model.showedButtons }
            set { model.showedButtons = newValue }
        }
        
        /// An array containing all the `InstructionStructure` elements.
        private var buttons: [ButtonsInstructionsModel.InstructionStructure] {
            [
                model.lights,
                model.vehicles,
                model.resources,
                model.travels
            ]
        }
        
        /// Indicates whether the tap animation is in progress.
        var tapAnimation: Bool {
            get { model.tapAnimation }
            set { model.tapAnimation = newValue }
        }
        
        /// Method that adds an `InstructionStructure` element to the `showedButtons` array.
        /// If the buttons to show end, the method toggles the `goToNextView` variable to navigate to the next view
        func showInstruction() {
            
            if showedButtons.count < buttons.count{
                let index = showedButtons.count
                showedButtons.append(buttons[index])
            } else {
                goToNextView.toggle()
            }
            
            
            // Play a system sound to indicate the tap gesture.
            AudioServicesPlaySystemSound(1103)
        }
        
    }
}
