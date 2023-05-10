//
//  ARExperience.swift
//  SolarBear
//
//  Created by Vincenzo Pascarella on 19/04/23.
//

import Foundation
import RealityKit

/// You can use this class to load an AR experience from a reality file and create anchor entities for it.
class ARExperience: RealityKit.Entity, RealityKit.HasAnchoring {
    
    /// Loads an AR experience from a reality file with the given name.
    ///
    /// Use this method to load an AR experience from a reality file with the given name.
    /// - Parameter resourceName: The name of the reality file to load.
    /// - Returns: The AR experience entity loaded from the reality file.
    static func load(named resourceName: String) -> ARExperience {
        let url = Bundle.main.url(forResource: resourceName, withExtension: "reality")!
        print("ciao: \(url)")
        let anchor = try! ARExperience.loadAnchor(contentsOf: url)
        return ARExperience(anchor: anchor)
    }

    required init() {
        super.init()
    }

    required init(anchor: RealityKit.AnchorEntity) {
        super.init()
        self.anchoring = anchor.anchoring
        self.addChild(anchor)
    }

}
