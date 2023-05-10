//
//  GameView.swift
//  SolarBear
//
//  Created by Vincenzo Pascarella on 15/04/23.
//

import SwiftUI

/// This struct defines the game interface of the app.
///
/// The view displays an image of a solar bear and text with the current bear instruction on the left.
/// The view also contains buttons for each component of the game. When a button is tapped, its state is toggled and the change is animated.
struct GameView: View {
    
    @ObservedObject var viewModel = GameViewModel()
    
    /// When toggled `true` it resets the SceneKitView's Camera
    @State private var reset = false
    
    var body: some View {
        
        GeometryReader { geo in
            
            VStack {
                
                HStack {
                    
                        // Add a resizable image of the solar bear to the left of the screen
                        Image(.solarBear)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geo.size.width * 0.25, height: geo.size.height / 5)
                    
                    Spacer()
                    
                        // Add text with the current bear instruction to the right of the screen
                        Text(viewModel.bearInstruction)
                            .foregroundColor(.white)
                            .font(.largeTitle.bold())
                            .multilineTextAlignment(.leading)
                            .frame(width: geo.size.width * 0.7, height: geo.size.height / 5)
                    
                }//HStack
                .frame(width: geo.size.width * 0.95)
                .padding(.horizontal)
                
                
                HStack {
                    
                    Button {
                        reset.toggle()
                    } label: {
                        GameViewActionButton(withText: "Reset")
                            .padding(.leading)
                    }
                    
                    Spacer()
                    
                    Button {
                        viewModel.goToAR.toggle()
                    } label: {
                        GameViewActionButton(withText: "AR")
                            .padding(.trailing)
                    }
                    
                }//HStack
                
                SceneKitView(icebergName: viewModel.iceberg, reset: $reset)
                
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
            
        }//GeometryReader
        .onAppear {
            viewModel.startInstructionAnimation()
        }
        .onDisappear {
            viewModel.stopInstructionAnimation()
        }
        .background(BackgroundView(type: .dark))
        .navigationDestination(isPresented: $viewModel.goToAR) {
            ARGameView()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
