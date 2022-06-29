//
//  CharacterSettingView.swift
//  RandomDice
//
//  Created by 陳昕喬 on 2022/6/4.
//

import SwiftUI

struct CharacterSettingView: View {
    @EnvironmentObject var player: Character
    @State var isImageSetting: Bool = false
    @State var isGameHomeShow: Bool = false
    @Binding var isCaracterSettingShow: Bool
    
    var body: some View {
        ZStack{
            Image("LoginBackground")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
                .opacity(0.5)
            ZStack{
                Rectangle()
                    .foregroundColor(.white)
                    .opacity(0.8)
                
                VStack(alignment: .leading, spacing: 25){
                    HStack{
                        Spacer()
                        Text("角色資料")
                            .font(.custom("DFWaWa-W5-WINP-BF", fixedSize: 50))
                        Spacer()
                    }
                    
                    HStack{
                        Text("姓名：")
                            .font(.custom("DFWaWa-W5-WINP-BF", fixedSize: 20))
                        TextField("請輸入使用者名稱", text: $player.name)
                            .textFieldStyle(.roundedBorder)
                    }
                    
                    HStack{
                        Text("貓派還是狗派？")
                            .font(.custom("DFWaWa-W5-WINP-BF", fixedSize: 20))
                        Picker(selection: $player.selection) {
                            Text("貓派")
                                .foregroundColor(.black)
                                .font(.custom("DFWaWa-W5-WINP-BF", fixedSize: 20))
                                .tag(0)
                            Text("狗派")
                                .foregroundColor(.black)
                                .font(.custom("DFWaWa-W5-WINP-BF", fixedSize: 20))
                                .tag(1)
                        } label: {
                            Text("選擇角色")
                        }
                        .frame(width: 100, height: 50)
                    }
                    
                    HStack {
                        Text("信箱：")
                            .font(.custom("DFWaWa-W5-WINP-BF", fixedSize: 20))
                        Text(player.email)
                            .font(.custom("DFWaWa-W5-WINP-BF", fixedSize: 20))
                    }
                    
                    HStack{
                        Text("錢錢：")
                            .font(.custom("DFWaWa-W5-WINP-BF", fixedSize: 20))
                        Text(String(player.coin))
                            .font(.custom("DFWaWa-W5-WINP-BF", fixedSize: 20))
                    }
                    
                    HStack{
                        Text("賭金：\(Int(player.bet))")
                            .font(.custom("DFWaWa-W5-WINP-BF", fixedSize: 20))
                        Slider(value: $player.bet, in: 0...Double(player.coin), step: 1)
                            .tint(.orange)
                    }
                    
                    HStack{
                        Text("加入時間：")
                            .font(.custom("DFWaWa-W5-WINP-BF", fixedSize: 20))
                        Text(String(player.startTime))
                            .font(.custom("DFWaWa-W5-WINP-BF", fixedSize: 20))
                    }
                    
                    HStack{
                        Spacer()
                        Button {
                            isImageSetting = true
                        } label: {
                            ZStack{
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
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(.black)
                                        .opacity(0.8)
                                    Text("編輯")
                                        .font(.custom("DFWaWa-W5-WINP-BF", fixedSize: 30))
                                        .foregroundColor(.white)
                                }
                                .frame(width: 250, height: 50)
                                .offset(x: 0, y: 75)
                                
                            }
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .cornerRadius(100)
                        }
                        
                        Spacer()
                    }
                    
                    HStack{
                        Spacer()
                        
                        Button {
                            //  設定上傳檔案
                            player.updateCharacterData()
                            
                            //  檢查是否開啟過首頁
                            if player.isFistSet == true
                            {
                                isGameHomeShow = true
                            }
                            else
                            {
                                isCaracterSettingShow = false
                            }
                        } label: {
                            ZStack{
                                Rectangle()
                                    .foregroundColor(.brown)
                                    .opacity(0.9)
                                    .cornerRadius(20)
                                Text("保存")
                                    .foregroundColor(.black)
                                    .font(.custom("DFWaWa-W5-WINP-BF", size: 30))
                            }
                            .frame(width: 250, height: 60)
                        }
                        
                        Spacer()
                        
                    }
                }
            }
            .frame(width: 330)
        }
        .fullScreenCover(isPresented: $isImageSetting) {
            ImageSettingView(isImageSettingViewShow: $isImageSetting)
        }
        .fullScreenCover(isPresented: $isGameHomeShow) {
            GameHomeView()
                .environmentObject(player)
        }
    }
}

struct CharacterSettingView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterSettingView(isCaracterSettingShow: .constant(true))
            .environmentObject(Character())
    }
}
