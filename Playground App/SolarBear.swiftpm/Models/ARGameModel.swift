//
//  ARGameModel.swift
//  SolarBear
//
//  Created by Vincenzo Pascarella on 19/04/23.
//

import Foundation

struct ARGameModel {
    
    /// An array of `Button` objects representing the different buttons in the game.
    var buttons = [
        Button(id: "ARlights", red: "IncandescentLight", green: "LedLight"),
        Button(id: "ARvehicles", red: "GasPowered", green: "ElectricVehicles"),
        Button(id: "ARresources", red: "CarbonCentral", green: "RenewablePower"),
        Button(id: "ARtravels", red: "AirTravel", green: "EcoTravel"),
    ]
    
    /// An array of strings representing the icebergs' scene to show in the game.
    let icebergs = [
    "Iceberg5",
    "Iceberg4",
    "Iceberg3",
    "Iceberg2",
    "Iceberg1"
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
