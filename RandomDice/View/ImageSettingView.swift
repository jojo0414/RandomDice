//
//  ImageSettingView.swift
//  RandomDice
//
//  Created by 陳昕喬 on 2022/6/4.
//

import SwiftUI
import WebKit

struct RectSettings: View {
    @Binding var rect: CGRect
    var body: some View {
        GeometryReader { geometry in
            setView(proxy:geometry)
        }
    }
    
    func setView(proxy: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            rect = proxy.frame(in: .global)
            //rect = CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: Int(UIScreen.main.bounds.width)-500)
        }
        return Rectangle().fill(Color.clear)
    }
}

struct ImageSettingView: View {
    @Binding var isImageSettingViewShow: Bool
    @State var rect: CGRect = .zero
    @State var roleImage: UIImage? = nil
    @EnvironmentObject var player: Character
    
    var webView: some View {
        WebView(webUrl: player.selection == 0 ? "https://picrew.me/image_maker/35494" : "https://picrew.me/image_maker/28629")
            .background(RectSettings(rect: $rect))
            .environmentObject(player)
    }
    
    var body: some View {
        VStack{
            Text("製作角色頭像")
                .frame(maxWidth: .infinity)
                .font(.custom("DFWaWa-W5-WINP-BF", fixedSize: 50))
                .padding()
                .background(.brown)
                .foregroundColor(.white)
            
            webView
            
            Button {
                //截圖
                let controller = UIViewController.getLastPresentedViewController()
                roleImage = controller?.view!.setImage(rect: rect)
                
                //上傳截圖
                player.uploadPhoto(image: roleImage!) { result in
                    switch result {
                    case .success(let url):
                        player.setUserPhoto(url: url)
                        player.image = url
                        print(url)
                    case .failure(let error):
                        print(error)
                    }
                }
                
                isImageSettingViewShow = false
            } label: {
                Text("儲存影像")
                    .frame(maxWidth: .infinity)
                    .font(.custom("DFWaWa-W5-WINP-BF", fixedSize: 30))
                    .foregroundColor(.white)
                    .padding()
                    .background(.brown)

            }

        }
    }
}

extension UIView {
    func setImage(rect: CGRect) -> UIImage {
        let rect2 = CGRect(x: -20, y: 285, width: 400, height: 300)
        let renderer = UIGraphicsImageRenderer(bounds: rect2)
        return renderer.image{ rendererContect in
            layer.render(in: rendererContect.cgContext)
        }
    }
}

extension UIViewController {
    static func getLastPresentedViewController() -> UIViewController? {
        let scene = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first { $0 is UIWindowScene } as? UIWindowScene
        let window = scene?.windows.first { $0.isKeyWindow }
        var presentedViewController = window?.rootViewController
        while presentedViewController?.presentedViewController != nil {
            presentedViewController = presentedViewController?.presentedViewController
        }
        return presentedViewController
    }
}
