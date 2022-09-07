//
//  MainMessagesViewModel.swift
//  Netflix-Clone
//
//  Created by Huy Bui Thanh on 29/08/2022.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

class MainMessagesViewModel: ObservableObject {

    @Published var errorMessage = ""
    @Published var chatUser: User?
    @Published var isUserCurrentlyLoggedOut = false
    
    // MARK: Initialize
    init() {
        DispatchQueue.main.async {
                    self.isUserCurrentlyLoggedOut = FirebaseManager.shared.auth.currentUser?.uid == nil
                }
        fetchCurrentUser()
    }

    // MARK: Fetch User
    func fetchCurrentUser() {

        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            self.errorMessage = "Could not find firebase uid"
            return
        }
        
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                self.errorMessage = "Failed to fetch current user: \(error)"
                print("Failed to fetch current user:", error)
                return
            }
            
            guard let data = snapshot?.data() else {
                self.errorMessage = "No data found"
                return
                
            }
            
            self.chatUser = .init(data: data)
        }
        
    }
    
  
    // MARK: Handle Sign Out
    func handleSignOut() {
            isUserCurrentlyLoggedOut.toggle()
            try? FirebaseManager.shared.auth.signOut()
        }

}
