//
//  ButtonsInstructionsView.swift
//  SolarBear
//
//  Created by Vincenzo Pascarella on 16/04/23.
//

import SwiftUI

/// A view that displays instructions for each button in the game
struct ButtonsInstructionsView: View {
    
    @ObservedObject var viewModel = ButtonsInstructionsViewModel()
    
    /// Defined the text color
    private let textColor = Color.white
    
    var body: some View {
        
        GeometryReader { geo in
            
            VStack {
                
                // Add a spacer if there are fewer than three buttons to center the content
                if viewModel.showedButtons.count < 3 {
                    Spacer()
                }
                
                ForEach(viewModel.showedButtons){ button in
                    
                    VStack(alignment: .leading) {
                        
                        HStack {
                            
                            geo.adaptiveStack {
                                
                                Image(button.redButton)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geo.size.width / 8)
                                
                                Text(button.redAction)
                                    .font(.title2.bold())
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.5)
                                    .foregroundColor(textColor)
                                
                                if !geo.isPortrait {
                                    Spacer()
                                }
                                
                            }//AdaptiveStackRedButton
                            .frame(width: geo.size.width / 2)
                            
                            Spacer()
                            
                            geo.adaptiveStack {
                                
                                Image(button.greenButton)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geo.size.width / 8)
                                
                                
                                Text(button.greenAction)
                                    .font(.title2.bold())
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.5)
                                    .foregroundColor(textColor)
                                
                                if !geo.isPortrait {
                                    Spacer()
                                }
                                
                            }//AdaptiveStackGreenButton
                            .frame(width: geo.size.width / 2)
                            
                        }//HStackButtons
                        .padding(.bottom, 1)
                        
                        Text(button.instruction)
                            .font(.title2)
                            .foregroundColor(textColor)
                            .padding(.horizontal)
                        
                    }//VStackForEach
                    
                    Spacer()
                    
                }//ForEach
                
                HStack {
                    Spacer()
                    
                    Text("Tap to continue")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 10)
                        .opacity(viewModel.tapAnimation ? 1 : 0)
                        .onAppear {
                            DispatchQueue.main.async {
                                withAnimation(.easeInOut(duration: 1).delay(3).repeatForever(autoreverses: true)) {
                                    viewModel.tapAnimation.toggle()
                                }
                            }
                        }
                    
                    Spacer()
                }//HStackTapToContinue
                
            }//VStack
            .padding(.horizontal)
            .padding(.top)
            
        }//GeometryReader
        .background(Color.blue.opacity(0.3))
        .background(Color.black)
        .onTapGesture {
            DispatchQueue.main.async {
                withAnimation {
                    viewModel.showInstruction()
                }
            }
        }
        .navigationTitle("Instructions")
        .toolbar(.hidden)
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $viewModel.goToNextView) {
            GameView()
        }
    }
}

struct ButtonInstructionView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsInstructionsView()
    }
}
