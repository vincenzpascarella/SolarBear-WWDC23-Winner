//
//  ARViewExperience.swift
//  SolarBear
//
//  Created by Vincenzo Pascarella on 19/04/23.
//

import SwiftUI
import ARKit
import RealityKit

/// A SwiftUI view that provides an AR experience with ARKit and RealityKit.
struct ARViewExperience: UIViewRepresentable {
    
    /// The name of the iceberg reality file to load
    let icebergARName: String
    
    /// The AR view type associated with this representable.
    typealias UIViewType = ARView

    /// Creates and configures an AR view with the session configuration.
    func makeUIView(context: Context) -> ARView {
        
        // Initialize an AR view.
        let arView = ARView(frame: .zero)
        
        // Create and run a new session configuration with horizontal and vertical plane detection enabled.
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        
        // Set scene reconstruction to mesh if the feature is supported.
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh){
            configuration.sceneReconstruction = .mesh
        }
        
        // Set the lighting intensity exponent of the environment.
        arView.environment.lighting.intensityExponent = 1
                
        // Add coaching overlay to the AR view.
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.activatesAutomatically = true
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.session = arView.session
        coachingOverlay.goal = .horizontalPlane
        coachingOverlay.delegate = context.coordinator
        arView.addSubview(coachingOverlay)
        
        // Start the AR session with the configuration.
        arView.session.run(configuration)
        
        return arView
    }

    /// Adds an experience anchor to the AR scene.
    func updateUIView(_ uiView: ARView, context: Context) {
        
        // Load an experience anchor from the specified Reality Composer file.
        let experience = ARExperience.load(named: icebergARName)
        
        // Remove the current anchor if it exists
         if let currentAnchor = uiView.scene.anchors.first {
             uiView.scene.removeAnchor(currentAnchor)
         }
                
        // Add the experience anchor to the AR scene.
        return uiView.scene.addAnchor(experience)
    }
    
    /// Creates and returns a coordinator object to handle the AR coaching overlay view delegate methods.
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    /// A coordinator object to handle the AR coaching overlay view delegate methods.
    class Coordinator: NSObject, ARCoachingOverlayViewDelegate {
        
        /// Notifies the delegate that the coaching overlay view has been deactivated.
        func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
            print("Coaching overlay deactivated.")
        }
        
        /// Notifies the delegate that the coaching overlay view is about to be activated.
        func coachingOverlayViewWillActivate(_ coachingOverlayView: ARCoachingOverlayView) {
            print("Coaching overlay will activate.")
        }
        
        /// Notifies the delegate that the coaching overlay view has requested the AR session to reset.
        func coachingOverlayViewDidRequestSessionReset(_ coachingOverlayView: ARCoachingOverlayView) {
            print("Session reset requested.")
        }
        
    }
}

struct ARViewExperience_Previews: PreviewProvider {
    static var previews: some View {
        ARViewExperience(icebergARName: "Iceberg1")
    }
}
