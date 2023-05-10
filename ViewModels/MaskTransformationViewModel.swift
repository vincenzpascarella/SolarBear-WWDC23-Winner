//
//  MaskTransformationViewModel.swift
//  SolarBear
//
//  Created by Vincenzo Pascarella on 14/04/23.
//

import SwiftUI

extension MaskTransformationView {
    
    class MaskTransformationViewModel: ObservableObject {
        
        @Published private var model = MaskTransformationModel()
        
        /// Indicates whether to navigate to the next view or not.
        @Published var goToNextView = false
        
        /// The location of the mask image on the screen.
        var maskLocation: CGPoint? {
            model.maskLocation
        }
        
        /// A boolean value that indicates whether the mask has been taken or not.
        var isTheMaskTaken: Bool {
            get { model.isTheMaskTaken }
            set { model.isTheMaskTaken = newValue }
        }
        
        /// The final location where the mask needs to be.
        var finalMaskPosition: CGPoint? {
            model.finalMaskPosition
        }
        
        /// A boolean value that indicates whether the mask has reached its final destination.
        var isInFinalLocation: Bool {
            model.isInFinalLocation
        }
        
        /// A computed property that returns the instruction text to display on the screen.
        ///
        /// If the mask is in its final location, the text returned is the congratulatory text prompting the user to tap to continue. Otherwise, the text returned is the instruction prompting the user to tap to reset the mask position.
        var instructionText: String {
            isInFinalLocation ? model.congratulationText : model.resetPositionText
        }
        
        /// Updates the mask location to a new value
        /// - Parameter newLocation: The new location for the mask
        func setNewLocation(in newLocation: CGPoint) {
            model.maskLocation = newLocation
        }
        
        /// Handles the tap gesture on the mask by setting the maskLocation and finalMaskPosition properties.
        ///
        /// - Parameters:
        ///   - geo: The geometry proxy of the image containing the mask.
        ///   - viewSize: The size of the view containing the image and mask.
        func handleMaskTapLocation(with geo: GeometryProxy, in viewSize: CGSize) {
            withAnimation() {
                model.maskLocation = CGPoint(x: geo.frame(in: .local).midX, y: geo.frame(in: .local).midY)
                
                model.finalMaskPosition = CGPoint(x: geo.frame(in: .local).midX - (viewSize.width - (viewSize.height / 2)), y: geo.frame(in: .local).midY - (viewSize.height - (viewSize.height / 2)))
            }
        }
        
        /// Determines the action to be taken when the instruction text is tapped.
        ///
        /// If the mask isn't in its final location, this method calls the `resetMaskPosition()` method to reset the mask position. Otherwise, it goes to the next View.
        func instructionAction() {
            if isInFinalLocation {
                goToNextView.toggle()
            } else {
                resetMaskPosition()
            }
        }
        
        /// Resets the mask position, sets isTheMaskTaken and isInFinalLocation properties to false and maskLocation property to nil.
        func resetMaskPosition() {
            model.maskLocation = nil
            model.isTheMaskTaken = false
            model.isInFinalLocation = false
        }
        
        
        /// Determines whether the given location is close enough to the final position based on the maximum distance threshold. Sets the `isInFinalLocation` accordingly.
        ///
        /// Use this method to check if the user has successfully moved the mask to its final destination. The function will calculate the distance between the given location and the final position and set the model's `isInFinalLocation` property accordingly.
        ///
        /// - Parameters:
        ///   - location: The current location of the mask.
        ///   - finalPosition: The final position of the mask.
        ///   - maxDistance: The maximum distance threshold. Default value is 50.0.
        ///
        func isFinalLocation(_ location: CGPoint, withFinalPosition finalPosition: CGPoint, maxDistance: CGFloat = 50.0) {
            let xDistance = abs(location.x - finalPosition.x)
            let yDistance = abs(location.y - finalPosition.y)
            model.isInFinalLocation = xDistance <= maxDistance && yDistance <= maxDistance
        }
        
    }
    
}
