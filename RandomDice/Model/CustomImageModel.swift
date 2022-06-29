//
//  CustomImageModel.swift
//  RandomDice
//
//  Created by 陳昕喬 on 2022/6/18.
//

import Foundation
import SwiftSoup
import WebKit

class CustomImageModel: NSObject, ObservableObject{
    @Published var imageURL: String = ""
    @Published var webURL: String = ""
    let webView = WKWebView()
    
    
}

extension CustomImageModel : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.webURL = webView.url?.absoluteString ?? ""
    }
}
