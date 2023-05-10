//
//  MaskTransformationViewDragGesture.swift
//  SolarBear
//
//  Created by Vincenzo Pascarella on 14/04/23.
//

import SwiftUI

extension MaskTransformationView {
    
    /// A gesture that allows the user to drag the mask image around the screen.
    var maskDrag: some Gesture {
        
        DragGesture()
            .onChanged { value in
                if let maskLocation = viewModel.maskLocation,
                   let finalMaskPosition = viewModel.finalMaskPosition {
                    var newLocation = maskStartLocation ?? maskLocation
                    newLocation.x += value.translation.width
                    newLocation.y += value.translation.height
                    
                    viewModel.isFinalLocation(newLocation, withFinalPosition: finalMaskPosition)
                    
                    viewModel.setNewLocation(in: newLocation)
                }
            }.updating($maskStartLocation) { (value, startLocation, transaction) in
                startLocation = startLocation ?? viewModel.maskLocation
            }
        
    }//maskDrag Gesture
}
