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
    
    // MARK: Properties
    @Published var errorMessage = ""
    @Published var chatUser: User?
    @Published var isUserCurrentlyLoggedOut = false
    @Published var savedLists: [SaveList] = []
   
    // MARK: Initialize
    init() {
        DispatchQueue.main.async {
            self.isUserCurrentlyLoggedOut = FirebaseManager.shared.auth.currentUser?.uid == nil
        }
        fetchCurrentUser()
    }
    
    func printList(){
        for list in savedLists {
            print("\(list)")
        }
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
    
    //MARK: PUT API REQUEST
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
    
    // MARK: FETCH API
    func fetch() {
        self.fetchCurrentUser()
        print("Fetching")
        //guard let url = URL(string: "https://backend-ios.herokuapp.com/saveList/update/\(userName)/\(movieID)") else {
        let username = (self.chatUser?.email ?? "")
        guard let url = URL(string: "https://backend-ios.herokuapp.com/saveList/userName/\(username)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            // Convert to JSON
            do {
                print("Decoding")
                let savedLists = try JSONDecoder().decode([SaveList].self, from: data)
                DispatchQueue.main.async {
                    self?.savedLists = savedLists
                }
                print("SUCCESSs")
                print("User: \(username)")
                print(self?.chatUser?.email ?? "")
                print(url)
                print(String(describing: type(of: url)))
                print("List")
                self!.printList()
            }
            catch {
                print("FAILs: \(error)")
                print("User: \(username)")
                print(self?.chatUser?.email ?? "")
                print((self?.chatUser?.email ?? "")!)
                print(url)
                print("List")
                self!.printList()
            }
        }
        task.resume()
    }
    
    // MARK: POST API REQUEST
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

