//
//  RandomDiceApp.swift
//  RandomDice
//
//  Created by 陳昕喬 on 2022/5/4.
//

import SwiftUI
import Firebase

@main
struct RandomDiceApp: App {
    init() {
            FirebaseApp.configure()
        }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
