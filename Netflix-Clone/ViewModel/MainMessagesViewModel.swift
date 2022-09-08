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
    @Published var savedLists: [Movie] = []
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
    
    func putData(movieID: Int, title: String) {
        guard let url = URL(string: "https://backend-ios.herokuapp.com/saveList/update/\(chatUser?.email ?? "")/\(movieID)") else {
            return
        }
        
        print("Making api calls...")
        var request  = URLRequest(url: url)
        
        // method, body, headers
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("\(movieID)")
        print("\(title)")
        let body: [String: AnyHashable] = [
            "movieID": movieID,
            "title": title
            
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        // Make the request
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("SUCCESS: \(response)")
            }
            catch {
                print("FAIL: \(error)")
            }
        }
        task.resume()
    }
    // MARK: fetch api
    func fetch() {
        print("Fetching")
        //guard let url = URL(string: "https://backend-ios.herokuapp.com/saveList/update/\(userName)/\(movieID)") else {
        guard let url = URL(string: "https://backend-ios.herokuapp.com/saveList/huepham1707") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            // Convert to JSON
            do {
                let savedLists = try JSONDecoder().decode([Movie].self, from: data)
                DispatchQueue.main.async {
                    self?.savedLists = savedLists
                }
                print("SUCCESS")
            }
            catch {
                print("FAIL: \(error)")
            }
        }
        task.resume()
    }
    
    func makePostRequest(name: String, pass: String) {
        guard let url = URL(string: "https://backend-ios.herokuapp.com/user") else {
            return
        }
        
        print("Making api calls...")
        var request  = URLRequest(url: url)
        
        // method, body, headers
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("\(name)")
        print("\(pass)")
        let body: [String: AnyHashable] = [
            "userName": name,
            "password": pass
            
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        // Make the request
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("SUCCESS: \(response)")
            }
            catch {
                print("FAIL: \(error)")
            }
        }
        task.resume()
    }
}

