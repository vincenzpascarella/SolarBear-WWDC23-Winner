//
//  MaskTransformationView.swift
//  SolarBear
//
//  Created by Vincenzo Pascarella on 15/04/23.
//

import SwiftUI
import AVFoundation

/// A view that allows the user to move a mask image around and drop it on a final position.
///
/// This view allows the user to interact with a mask image and drag it around the screen using their finger.
/// Once the mask is dropped, it will snap into a final position and display a message indicating that it has reached its final destination.
struct MaskTransformationView: View {
    
    @ObservedObject var viewModel = MaskTransformationViewModel()
    
    /// The starting location of the mask when the user begins to drag it.
    @GestureState var maskStartLocation: CGPoint? = nil
    
    var body: some View {
        
        GeometryReader { geo in
                        
            VStack{
                
                HStack {
                    
                    Image(viewModel.isInFinalLocation ? .solarBear : .polarBear)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geo.size.height / 2)
                    
                    Spacer()
                    
                }//HStack BearHead
                
                Spacer()
                
                ZStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        ZStack {
                            
                            GeometryReader { imageGeometry in
                                Image(viewModel.isTheMaskTaken ? .pedestal : .maskPedestal)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .contentShape(Rectangle().scale(x: 0.5, y: 0.3))
                                    .onTapGesture {
                                        guard !viewModel.isTheMaskTaken else { return }
                                        viewModel.handleMaskTapLocation(with: imageGeometry, in: geo.size)
                                        viewModel.isTheMaskTaken.toggle()
                                        
                                        // Play a system sound to indicate the tap gesture.
                                        AudioServicesPlaySystemSound(1103)
                                    }
                                    .background(
                                        Ellipse()
                                            .foregroundColor(.black)
                                            .scaleEffect(x: 1, y: 0.55, anchor: .bottom)
                                            .padding(.bottom)
                                            .blur(radius: 20)
                                            .opacity(0.5)
                                    )
                            }//InnerGeometryReader
                            
                            if let maskLocation = viewModel.maskLocation, viewModel.isTheMaskTaken && !viewModel.isInFinalLocation {
                                Image(.bearMask)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .contentShape(Rectangle().scale(x: 0.7, y: 0.3))
                                    .position(maskLocation)
                                    .gesture(
                                        maskDrag
                                    )
                            }
                            
                        }//ZStack Pedestal
                        .frame(width: geo.size.height / 2)
                        
                    }//HStack Pedestal
                    
                    if viewModel.isTheMaskTaken{
                        VStack {
                            Spacer()
                            Button{
                                viewModel.instructionAction()
                            } label: {
                                Text(viewModel.instructionText)
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 5)
                                    .padding(.bottom)
                                    .lineLimit(1)
                                    .font(.largeTitle.bold())
                                    .minimumScaleFactor(0.5)
                            }
                        }//VStack
                    }//isTheMaskTaken
                    
                }//ZStack bottom screen
                
            }//VStack
            .padding(.horizontal)
            .onChange(of: geo.isPortrait) { _ in
                viewModel.resetMaskPosition()
            }
            
        }//GeometryReader
        .background(BackgroundView(type: .light))
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $viewModel.goToNextView) {
            TalkingView(isOnboarding: false)
        }
        
    }
    
}

struct MaskTransformationView_Previews: PreviewProvider {
    static var previews: some View {
        MaskTransformationView()
    }
}
