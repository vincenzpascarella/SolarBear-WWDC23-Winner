//
//  MyApp.swift
//  SolarBear
//
//  Created by Vincenzo Pascarella on 13/04/23.
//

import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            TalkingView(isOnboarding: true)
        }
    }
}
