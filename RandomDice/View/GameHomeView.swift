//
//  GameHomeView.swift
//  RandomDice
//
//  Created by 陳昕喬 on 2022/6/4.
//

import SwiftUI
import WebKit

struct GameHomeView: View {
    @EnvironmentObject var player: Character
    @State var isCharacterSettingShow: Bool = false
    
    var body: some View {
        ZStack {
            Image("LoginBackground")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
                .opacity(0.3)
            
            VStack{
                Button {
                    isCharacterSettingShow = true
                    print("button pressed")
                } label: {
                    HStack{
                        AsyncImage(url: player.image) { phase in
                            
                            switch phase {
                            case .empty:
                                Image("emptyImage")
                                    .resizable()
                            case .success(let image):
                                image
                                    .resizable()
                            case .failure(_):
                                Image("emptyImage")
                                    .resizable()
                            @unknown default:
                                Image("emptyImage")
                                    .resizable()
                            }
                        }
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .cornerRadius(100)
                        .padding()
                        
                        VStack(alignment: .leading, spacing: 7.5){
                            Text(player.name)
                                .font(.custom("DFWaWa-W5-WINP-BF", fixedSize: 15))
                                .foregroundColor(.black)
                            Text("錢錢：$\(player.coin)")
                                .font(.custom("DFWaWa-W5-WINP-BF", fixedSize: 15))
                                .foregroundColor(.black)
                            Text("賭金：$\(Int(player.bet))")
                                .font(.custom("DFWaWa-W5-WINP-BF", fixedSize: 15))
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                    }
                    .frame(width: 260, height: 100)
                    .background(.brown)
                    .opacity(0.9)
                    .cornerRadius(30)
                }
                .offset(x: -50, y: -180)
                
                ZStack{
                    Rectangle()
                        .foregroundColor(.brown)
                        .opacity(0.9)
                    VStack(spacing: 10){
                        HStack {
                            Text("隊伍：")
                                .font(.custom("DFWaWa-W5-WINP-BF", fixedSize: 20))
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding()
                        
                        HStack(spacing: 5){
                            Spacer()
                            ForEach(Range(1...5)){ index in
                                Rectangle()
                                    .foregroundColor(.white)
                                    .opacity(0.8)
                                    .aspectRatio(1, contentMode: .fit)
                            }
                            Spacer()
                        }
                        
                        Button {
                            
                        } label: {
                            HStack{
                                Spacer()
                                    Text("開始遊戲")
                                        .foregroundColor(.black)
                                        .font(.custom("DFWaWa-W5-WINP-BF", size: 20))
                                Spacer()
                            }
                            .padding()
                        }
                    }
                }
                .frame(width: 350, height: 200)
                .cornerRadius(30)
                .offset(x: 0, y: -30)
            }
            
        }
        .onAppear
        {
            player.isFistSet = false
        }
        .fullScreenCover(isPresented: $isCharacterSettingShow) {
            CharacterSettingView(isCaracterSettingShow: $isCharacterSettingShow)
                .environmentObject(player)
        }
    }
}

struct GameHomeView_Previews: PreviewProvider {
    static var previews: some View {
        GameHomeView()
            .environmentObject(Character())
    }
}
