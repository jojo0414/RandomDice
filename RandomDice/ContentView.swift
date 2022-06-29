//
//  ContentView.swift
//  RandomDice
//
//  Created by 陳昕喬 on 2022/5/4.
//

import SwiftUI

struct ContentView: View {
    @StateObject var player = Character()
    
    var body: some View {
        NavigationView{
            StartView()
                .environmentObject(player)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
