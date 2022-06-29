//
//  RegisterView.swift
//  RandomDice
//
//  Created by 陳昕喬 on 2022/6/4.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var showCharacterSettingView: Bool = false
    @State var showGameHomeView: Bool = false
    @State var isShowRegisterAlert: Bool = false
    @State var isShowLoginAlert: Bool = false
    @EnvironmentObject var player: Character
    
    var body: some View {
        ZStack {
            Image("LoginBackground")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
            
            ZStack{
                Rectangle()
                    .foregroundColor(.white)
                    .opacity(0.8)
                
                VStack(alignment: .leading){
                    HStack{
                        Spacer()
                        Text("遊戲登入")
                            .font(.custom("DFWaWa-W5-WINP-BF", fixedSize: 50))
                        Spacer()
                    }
                    HStack{
                        Text("帳號：")
                            .font(.custom("DFWaWa-W5-WINP-BF", fixedSize: 20))
                        TextField("請輸入電子信箱", text: $email)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding()
                    
                    HStack{
                        Text("密碼：")
                            .font(.custom("DFWaWa-W5-WINP-BF", fixedSize: 20))
                        TextField("請輸入密碼", text: $password, prompt: Text("password"))
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding()

                    Button {
                        Auth.auth().signIn(withEmail: email, password: password) { result, error in
                            if let x = error{
                                let err = x as NSError
                                switch err.code {
                                case AuthErrorCode.userNotFound.rawValue:
                                    print("尚未註冊帳號")
                                    
                                    Auth.auth().createUser(withEmail: email, password: password) { result_login, error_login in
                                        
                                        guard let user = result_login?.user,
                                              error_login == nil else {
                                            isShowRegisterAlert = true
                                            return
                                        }
                                        print(user, "註冊成功")
                                        player.email = email
                                        player.coin = 3000
                                        
                                        let formatter1 = DateFormatter()
                                        formatter1.dateStyle = .short
                                        
                                        player.startTime =
                                        formatter1.string(from: Date.now)
                                        showCharacterSettingView = true
                                    }
                                default:
                                    isShowLoginAlert = true
                                    return
                                }
                            }
                            else
                            {
                                showGameHomeView = true
                                player.getCharacterData(loginEmail: email)
                            }
                        }
                    } label: {
                        HStack{
                            Spacer()
                            ZStack{
                                Rectangle()
                                    .foregroundColor(.brown)
                                    .opacity(0.9)
                                    .cornerRadius(20)
                                Text("註冊 / 登入")
                                    .foregroundColor(.black)
                                    .font(.custom("DFWaWa-W5-WINP-BF", size: 30))
                            }
                            .frame(width: 250, height: 60)
                            Spacer()
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        HStack{
                            Spacer()
                            ZStack{
                                Rectangle()
                                    .foregroundColor(.brown)
                                    .opacity(0.9)
                                    .cornerRadius(20)
                                Text("Facebook 登入")
                                    .foregroundColor(.black)
                                    .font(.custom("DFWaWa-W5-WINP-BF", size: 30))
                            }
                            .frame(width: 250, height: 60)
                            Spacer()
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        HStack{
                            Spacer()
                            ZStack{
                                Rectangle()
                                    .foregroundColor(.brown)
                                    .opacity(0.9)
                                    .cornerRadius(20)
                                Text("Google 登入")
                                    .foregroundColor(.black)
                                    .font(.custom("DFWaWa-W5-WINP-BF", size: 30))
                            }
                            .frame(width: 250, height: 60)
                            Spacer()
                        }
                    }
                    
                }
            }
            .offset(x: 0, y: -50)
            .frame(width: 330, height: 500)
            .fullScreenCover(isPresented: $showCharacterSettingView) {
                CharacterSettingView(isCaracterSettingShow: .constant(true))
                    .environmentObject(player)
            }
            .fullScreenCover(isPresented: $showGameHomeView) {
                GameHomeView()
                    .environmentObject(player)
            }
            .alert("註冊失敗", isPresented: $isShowRegisterAlert) {
                Button("OK"){ }
            }
            .alert("登入失敗", isPresented: $isShowLoginAlert) {
                Button("OK"){}
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
