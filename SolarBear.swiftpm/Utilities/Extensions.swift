//
//  Extensions.swift
//  SolarBear
//
//  Created by Vincenzo Pascarella on 15/04/23.
//

import SwiftUI

// MARK: - GeometryProxy

extension GeometryProxy {
    
    /// Returns a boolean value indicating whether the device is in portrait orientation or not.
    ///
    /// This computed property calculates the aspect ratio of the device's screen based on its size, and returns true if the width is less than the height, indicating a portrait orientation. Otherwise, it returns false.
    var isPortrait: Bool {
        return self.size.width < self.size.height
    }
    
    /// Returns an `AnyLayout` object that allows the caller to use a generic layout type that is determined dynamically based on the device orientation.
    ///
    /// This computed property checks the `isPortrait` value to get the device orientation and returns a vertical `VStackLayout` if it's `true`, or a horizontal `HStackLayout` if it's `false`.
    var adaptiveStack: AnyLayout {
        return self.isPortrait ? AnyLayout(VStackLayout()) : AnyLayout(HStackLayout())
    }
    
}

// MARK: - Image init

extension Image {
    
    /// Convenience initializer to create an Image instance from an ImageName enum value.
    ///
    /// - Parameter name: An ImageName enum value that represents the name of the image to be created.
    init(_ name: ImageName){
        self.init(name.rawValue)
    }
    
}
