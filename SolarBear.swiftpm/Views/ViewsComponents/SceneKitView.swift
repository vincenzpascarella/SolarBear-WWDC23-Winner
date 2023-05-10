//
//  SceneKitView.swift
//  SolarBear
//
//  Created by Vincenzo Pascarella on 18/04/23.
//

import SwiftUI
import SceneKit

struct SceneKitView: UIViewRepresentable {
    
    /// The name of the iceberg file to load
    let icebergName: String
    
    @Binding var reset: Bool
    
    func makeUIView(context: Context) -> SCNView {
        
        // Create a SceneKit view
        let sceneView = SCNView()
        
        // Load the .scn object
        let scene = SCNScene(named: icebergName)!
        
        // Set the scene to the view
        sceneView.scene = scene
        
        // Enable user interactions (e.g. rotating the object)
        sceneView.allowsCameraControl = true
        
        // Create a camera
        let camera = SCNCamera()
        camera.zNear = 0
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        sceneView.pointOfView?.camera = cameraNode.camera
        
        // Disables rotation gesture recognizer for the given scene view.
        if let recognizers = sceneView.gestureRecognizers {
            for gestureRecognizer in recognizers {
                if gestureRecognizer is UIRotationGestureRecognizer {
                    gestureRecognizer.isEnabled = false
                } else if gestureRecognizer is UITapGestureRecognizer {
                    gestureRecognizer.isEnabled = false
                }
            }
        }
        
        // Customize camera controller to restrict rotation to horizontal axis
        let cameraController = sceneView.defaultCameraController
        cameraController.minimumVerticalAngle = 23.8
        cameraController.maximumVerticalAngle = 50
        
        
        // Enable default lighting and clear background color
        sceneView.autoenablesDefaultLighting = true
        sceneView.backgroundColor = .clear
        
        // Add rotation animation to the root node of the scene
        let rotation = SCNAction.rotateBy(x: 0, y: 1, z: 0, duration: 10)
        let repeatRotation = SCNAction.repeatForever(rotation)
        scene.rootNode.runAction(repeatRotation)
        
        /// Return the view
        return sceneView
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        
        var cameraNode = SCNNode()

        if reset {
            
            // Create a camera
            let camera = SCNCamera()
            camera.zNear = 0
            cameraNode.camera = camera
            uiView.pointOfView?.camera = cameraNode.camera
            
        } else {
            // Get the current camera node from the original scene
            if let oldCameraNode = uiView.pointOfView {
                cameraNode = oldCameraNode
            }
        }
        
        // Load the new scene with the specified icebergName
        let newScene = SCNScene(named: icebergName)!
        
        // Add rotation animation to the root node of the scene
        let rotation = SCNAction.rotateBy(x: 0, y: 1, z: 0, duration: 10)
        let repeatRotation = SCNAction.repeatForever(rotation)
        newScene.rootNode.runAction(repeatRotation)
        
        // Set the new scene to the view and update the camera node
        uiView.scene = newScene
        
        if reset {
            uiView.pointOfView?.camera = cameraNode.camera
        } else {
            uiView.pointOfView = cameraNode
        }
        
        // Checks if the reset is still true and make it false
        DispatchQueue.main.async{
            if reset {
                reset.toggle()
            }
        }
        
    }
}
