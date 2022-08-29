//
//  FirebaseManager.swift
//  Netflix-Clone
//
//  Created by Huy Bui Thanh on 29/08/2022.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore

// MARK: Class FirebaseManager
class FirebaseManager: NSObject {
    
    // MARK: Properties
    let auth: Auth
    let storage: Storage
    let firestore: Firestore
    
    static let shared = FirebaseManager()
    // MARK: Initialize Firebase
    override init() {
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
        
        super.init()
    }
    
}
