//
//  GameModel.swift
//  SolarBear
//
//  Created by Vincenzo Pascarella on 17/04/23.
//

import Foundation

struct GameModel {
    
    /// An array of `Button` objects representing the different buttons in the game.
    var buttons = [
        Button(id: "lights", red: "IncandescentLight", green: "LedLight"),
        Button(id: "vehicles", red: "GasPowered", green: "ElectricVehicles"),
        Button(id: "resources", red: "CarbonCentral", green: "RenewablePower"),
        Button(id: "travels", red: "AirTravel", green: "EcoTravel"),
    ]
    
    /// An array of strings representing the instructions for playing the game.
    let bearInstruction = [
        "Tap on the various button to enable/disable the effects of the main actors of global warming.",
        "Tap on the AR button to enjoy a wonderful augmented reality experience."
    ]
    
    /// An array of strings representing the icebergs' scene to show in the game.
    let icebergs = [
    "IcebergS5.scn",
    "IcebergS4.scn",
    "IcebergS3.scn",
    "IcebergS2.scn",
    "IcebergS1.scn"
    ]
    
    /// The number of active buttons in the game.
    var activeButtonCount = 0
    
    /// A struct representing the button in the game.
    struct Button: Identifiable {
        let id: String
        let red: String
        let green: String
        var isTapped: Bool = false
        var currentColor: String {
            isTapped ? green : red
        }
    }
}
