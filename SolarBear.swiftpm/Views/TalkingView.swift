//
//  TalkingView.swift
//  SolarBear
//
//  Created by Vincenzo Pascarella on 15/04/23.
//

import SwiftUI

/// A view that displays the talking screen with a Polar Bear character named Breesy.
///
/// This view animates and displays a Polar Bear named Breesy and guides the user through the onboarding or the game process.
struct TalkingView: View {
    
    /// Indicates whether the app is currently in onboarding mode or not.
    var isOnboarding = true
    
    @ObservedObject private var viewModel = TalkingViewModel()

    var body: some View {
        
        NavigationStack {
            
            GeometryReader { geo in
                
                VStack{
                    
                    Spacer()
                    
                    geo.adaptiveStack{
                        
                        Spacer()
                        
                        Image(isOnboarding ? .polarBear : .solarBear)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .shadow(color: .blue.opacity(viewModel.shadowScaling && !viewModel.isStarted ? 0 : 1), radius: viewModel.shadowScaling ? 0 : 150, x: 0, y: 0)
                            .onAppear {
                                DispatchQueue.main.async {
                                    withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                                        viewModel.shadowScaling.toggle()
                                    }
                                }
                            }
                        
                        if viewModel.isStarted{
                            Spacer()
                            
                            Text(viewModel.textToDisplay)
                                .font(.largeTitle.bold())
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 5)
                                .padding(.horizontal)
                                .background(
                                    Rectangle()
                                        .foregroundColor(.black)
                                        .opacity(geo.isPortrait ? 0.4 : 0.1)
                                        .blur(radius: 20)
                                        .scaleEffect(x: 1.1, y: 1.3)
                                )
                        }
                        
                        Spacer()
                        
                    }//adaptiveLayout
                    
                    Spacer()
                    
                    Text("Tap to continue")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 10)
                        .opacity(viewModel.tapAnimation ? 1 : 0)
                        .padding(.bottom)
                        .onAppear {
                            DispatchQueue.main.async{
                                withAnimation(.easeInOut(duration: 1).delay(3).repeatForever(autoreverses: true)) {
                                    viewModel.tapAnimation.toggle()
                                }
                            }
                        }
                    
                }//VStack
                .navigationDestination(isPresented: $viewModel.goToNextView){
                    if viewModel.isOnboarding {
                        MaskTransformationView()
                    } else {
                        ButtonsInstructionsView()
                    }
                }
                .frame(width: geo.size.width, height: geo.size.height)
                
            }//GeometryReader
            .background(BackgroundView(type: .dark))
            .onTapGesture{
                viewModel.tapGestureAnimation()
            }
            .onAppear{
                viewModel.isOnboarding = isOnboarding
                if isOnboarding {
                    viewModel.startMusic()
                }
            }
            .navigationBarBackButtonHidden()
            
        }//NavigationStack
        .navigationViewStyle(.stack)

    }
    
}

struct TalkingView_Previews: PreviewProvider {
    static var previews: some View {
        TalkingView()
    }
}
