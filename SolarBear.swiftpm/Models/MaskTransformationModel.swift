//
//  MaskTransformationModel.swift
//  SolarBear
//
//  Created by Vincenzo Pascarella on 14/04/23.
//

import Foundation

struct MaskTransformationModel {
    
    /// The location of the mask image on the screen.
    var maskLocation: CGPoint?
    
    /// A boolean value that indicates whether the mask has been taken or not.
    var isTheMaskTaken = false
    
    /// The final location where the mask needs to be.
    var finalMaskPosition: CGPoint?
    
    /// A boolean value that indicates whether the mask has reached its final destination.
    var isInFinalLocation = false
    
    /// The text that will be displayed to the user after they have correctly positioned the mask.
    let congratulationText = "Thanks, now tap here to continue"
    
    /// The reset position text displayed to the user to indicate that tapping on the text will reset the mask position.
    let resetPositionText = "Tap here to reset mask position"
}
