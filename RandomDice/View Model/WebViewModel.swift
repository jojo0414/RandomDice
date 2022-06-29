//
//  WebView.swift
//  RandomDice
//
//  Created by 陳昕喬 on 2022/6/4.
//

import SwiftUI
import WebKit


struct WebView: UIViewRepresentable {
    
    typealias UIViewType = WKWebView
    let webView = WKWebView()
    let webUrl: String
    
    
    func makeUIView(context: Context) -> WKWebView {
        
        if let url = URL(string: webUrl) {
            let request = URLRequest(url: url)
            print("make view")
            webView.load(request)
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        print("update!!")
    }
}
