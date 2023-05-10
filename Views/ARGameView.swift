//
//  ARGameView.swift
//  SolarBear
//
//  Created by Vincenzo Pascarella on 19/04/23.
//

import SwiftUI

/// A view representing the augmented reality game screen.
///
/// This view displays the augmented reality game's components and allows the user to interact with them.
struct ARGameView: View {
    
    @ObservedObject var viewModel = ARGameViewModel()
    
    var body: some View {
        
        GeometryReader { geo in
            
            ZStack {
                ARViewExperience(icebergARName: viewModel.iceberg)
                    .ignoresSafeArea()
                
                VStack {
                    
                    Spacer()
                    
                    HStack {
                        
                        Spacer()
                        
                        // Add buttons for each of the game's components
                        ForEach(viewModel.buttons){ button in
                            Image(button.currentColor)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geo.size.width / 6, height: geo.size.height / 6)
                                .onTapGesture {
                                    // When a button is tapped, toggle its state and animate the change
                                    DispatchQueue.main.async {
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            viewModel.toggle(button)
                                        }
                                    }
                                }
                                .shadow(color: .black.opacity(0.3), radius: 20)
                            
                            Spacer()
                            
                        }//ForEach
                        
                    }//HStack
                    
                }//VStack
                
            }//ZStack
            
        }//GeometryReader
    }
}

struct ARGameView_Previews: PreviewProvider {
    static var previews: some View {
        ARGameView()
    }
}
