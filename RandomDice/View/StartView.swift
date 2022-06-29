//
//  LoginView.swift
//  RandomDice
//
//  Created by 陳昕喬 on 2022/6/4.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var player: Character
    var body: some View {
        ZStack {
            Image("LoginBackground")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
            
            VStack{
                ZStack{
                    Rectangle()
                        .foregroundColor(.white)
                        .opacity(0.5)
                    
                    VStack{
                        Text("Random Dice")
                            .font(.custom("DFWaWa-W5-WINP-BF", fixedSize: 50))
                        Text("Cat v.s. Dog")
                            .font(.custom("DFWaWa-W5-WINP-BF", fixedSize: 50))
                    }
                    
                }
                .frame(width: 350, height: 120)
                .offset(x: 0, y: -20)
                
                NavigationLink {
                    LoginView()
                        .environmentObject(player)
                } label: {
                    ZStack{
                        Rectangle()
                            .foregroundColor(.brown)
                            .opacity(0.9)
                            .cornerRadius(20)
                        Text("登入 / 註冊")
                            .foregroundColor(.black)
                            .font(.custom("DFWaWa-W5-WINP-BF", size: 30))
                    }
                    .frame(width: 250, height: 60)
                }
            }
        }

    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
