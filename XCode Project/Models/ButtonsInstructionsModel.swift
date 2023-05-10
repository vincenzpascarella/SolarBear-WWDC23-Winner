//
//  ButtonsInstructionsModel.swift
//  SolarBear
//
//  Created by Vincenzo Pascarella on 16/04/23.
//

import Foundation

struct ButtonsInstructionsModel {
    
    /// An array of InstructionStructure objects that represents the currently showed buttons.
    var showedButtons = [InstructionStructure]()
        
    var lights = InstructionStructure(
        id: "lights",
        redButton: "IncandescentLight",
        greenButton: "LedLight",
        redAction: "Incandescent light bulbs",
        greenAction: "LED light bulbs",
        instruction: "Incandescent light bulbs waste energy as heat, are less efficient than LED bulbs. Switching to LED bulbs saves energy and helps the planet")
    
    var vehicles = InstructionStructure(
        id: "vehicles",
        redButton: "GasPowered",
        greenButton: "ElectricVehicles",
        redAction: "Gas-powered vehicles",
        greenAction: "Electric vehicles",
        instruction: "Gas vehicles emit harmful pollutants and contribute to climate change. Electric vehicles are energy-efficient, quieter, and use renewable energy.")
    
    var travels = InstructionStructure(
        id: "travels",
        redButton: "AirTravel",
        greenButton: "EcoTravel",
        redAction: "Air Travels",
        greenAction: "Eco Travels",
        instruction: "Air travel is a significant contributor to greenhouse gas emissions. Train travel emits fewer emissions, can be more affordable, and offer a more relaxed travel experience.")
    
    var resources = InstructionStructure(
        id: "resources",
        redButton: "CarbonCentral",
        greenButton: "RenewablePower",
        redAction: "Non-renewable energy",
        greenAction: "Renewable energy",
        instruction: "The extraction and burning of non-renewable sources of energy contribute to climate change. Renewable sources, such as solar and wind, are naturally replenishing and have minimal environmental impact.")
    
    /// Indicates whether the tap animation is in progress.
    var tapAnimation = true
    
    /// A struct that represents an instruction and its associated elements.
    struct InstructionStructure: Identifiable {
        let id: String
        let redButton: String
        let greenButton: String
        let redAction: String
        let greenAction: String
        let instruction: String
    }
}
