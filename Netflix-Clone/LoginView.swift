//
//  ContentView.swift
//  Netflix-Clone
//
//  Created by Huy Bui Thanh on 29/08/2022.
//

import SwiftUI

struct LoginView: View {
    
    // MARK: - Properties
    
    @State var isLoginMode = false
    @State var email = ""
    @State var password = ""
    
//    init() {
//        FirebaseApp.configure()
//    }
    // MARK: - Body
    var body: some View {
        NavigationView {
            ScrollView {
                
                VStack (spacing: 16){
                    // MARK: - Choosing Login or Sign up
                    Picker(selection: $isLoginMode, label: Text("Picker here")) {
                        Text("Login")
                            .tag(true)
                        Text("Create Account")
                            .tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    
                    // MARK: - User Image
                    if !isLoginMode {
                        Button {
                            
                        } label: {
                            Image(systemName: "person.fill")
                                .font(.system(size: 64))
                                .padding()
                        }
                    }
                    
                    // MARK: - Text Field for email and password
                    Group {
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)

                        SecureField("Password", text: $password)
                        
                    }
                    .padding(12)
                    .background(Color.white)
                    
                    // MARK: - Submit button
                    Button {
                        handleAction()
                    } label: {
                        HStack {
                            Spacer()
                            Text(isLoginMode ? "Log In" : "Create Account")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .font(.system(size: 14, weight: .semibold))
                            Spacer()
                        } .background(Color.blue)
                    }
                    
                } // VStack
                .padding()
            } // Navigation View
            .navigationTitle(isLoginMode ? "Log In" : "Create Account")
            .background(Color(.init(white: 0, alpha: 0.05))
                .ignoresSafeArea())
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // MARK: Function handle login
    private func handleAction() {
        if isLoginMode {
            print("Login Firebase with existing credentials")
        } else {
            //CreateNewAccount()
            print("Register a new account")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
