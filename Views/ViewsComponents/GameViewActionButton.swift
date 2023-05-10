//
//  GameViewActionButton.swift
//  SolarBear
//
//  Created by Vincenzo Pascarella on 19/04/23.
//

import SwiftUI

/// A button that displays a text and a border.
///
/// Use this button to display an action that the user can perform by tapping on it.
struct GameViewActionButton: View {
    
    /// The text to display on the button.
    let withText: String
    
    var body: some View {
        
        Text(withText)
            .font(.largeTitle.bold())
            .foregroundColor(.white)
            .padding(.horizontal, 32)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(.black, lineWidth: 4)
                    .padding(.horizontal, 16)
                    .padding(.vertical, -8)
                    .foregroundColor(.black)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 10)
                            .padding(.horizontal, 16)
                            .padding(.vertical, -8)
                            .foregroundColor(.black.opacity(0.2))
                    })
            )
        
    }
}

struct ARButton_Previews: PreviewProvider {
    static var previews: some View {
        GameViewActionButton(withText: "Reset")
    }
}
