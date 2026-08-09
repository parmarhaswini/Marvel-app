//
//  MarvelAppApp.swift
//  MarvelApp
//
//  Created by Haswini Parmar on 19/04/26.
//

import SwiftUI
import SwiftData

/// Main Entry point of the Marvel App
@main
struct MarvelAppApp: App {

    // this is temporary delay to launch main page
    // after launchscreen
    // this means = this will show launchscreen little bit more
//    init() {
//        Thread.sleep(forTimeInterval: 3)
//    }
    var body: some Scene {
        WindowGroup {
            WelcomeScreenView()
        }
    }
}
