//
//  BackgroundView.swift
//  SolarBear
//
//  Created by Vincenzo Pascarella on 14/04/23.
//

import SwiftUI

/// A view representing a background image with a given type.
struct BackgroundView: View {
    
    /// The name of the image file to be displayed as the background.
    let imageName: String
    
    /// Initializes a `BackgroundView` with the given type.
    ///
    /// - Parameter type: The type of the background image.
    init(type imageName: BackgroundType) {
        self.imageName = imageName.rawValue
    }
    
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
    }
}
