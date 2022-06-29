//
//  CharacterModel.swift
//  RandomDice
//
//  Created by 陳昕喬 on 2022/6/4.
//

import Foundation
import UIKit
import AVFoundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift

struct CharacterData: Codable, Identifiable{
    @DocumentID var id: String?
    var name: String
    var selection: Int //0 -> 貓貓、1 -> 狗狗
    var email: String
    var coin: Int
    var image: String //需要將 URL 轉為 String
    var bet: Double
    var startTime: String
}

class Character: ObservableObject{
    @Published var name: String = ""
    @Published var selection: Int = 0 //0 -> 貓、1 - > 狗
    @Published var email: String = ""
    @Published var coin: Int = 0
    @Published var image: URL? = URL(string: "")
    @Published var isFistSet: Bool = true
    @Published var bet: Double = 100
    @Published var startTime: String = ""
    
    func setUserPhoto(url: URL) {
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.photoURL = url
            changeRequest?.commitChanges(completion: { error in
               guard error == nil else {
                   print(error?.localizedDescription)
                   return
               }
            })
    }
    
    //將照片存到firebase
    func uploadPhoto(image: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
            
            let fileReference = Storage.storage().reference().child("image/\(UUID().uuidString).jpg")
            if let data = image.jpegData(compressionQuality: 0.9) {
                
                fileReference.putData(data, metadata: nil) {  result in
                    switch result {
                    case .success(_):
                         fileReference.downloadURL(completion: completion)
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
    }
    
    func updateCharacterData() {
        let db = Firestore.firestore()
        
        
        let data = CharacterData(name: name, selection: selection, email: email, coin: coin, image: image?.absoluteString ?? "", bet: bet, startTime: startTime)
            do {
                try db.collection("character").document("\(name)").setData(from: data)
                print("update character data succeeded")
            } catch {
                print("update character fail: \(error)")
            }
    }
    
    func getCharacterData(loginEmail: String) {
        let db = Firestore.firestore()
        db.collection("character").whereField("email", isEqualTo: "\(loginEmail)").getDocuments { snapshot, error in
                
             guard let snapshot = snapshot else { return }
            
             let data = snapshot.documents.compactMap { snapshot in
                 try? snapshot.data(as: CharacterData.self)
             }
             print("get character = \(data)")
            
            if let data = data.first{
                self.name = data.name
                self.selection = data.selection
                self.email = data.email
                self.coin = data.coin
                self.image = URL(string: data.image)
                self.bet = data.bet
                self.startTime = data.startTime
            }
         }
        
    }
}
