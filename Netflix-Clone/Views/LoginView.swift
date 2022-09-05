/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Author:
    Bui Thanh Huy
    Hoang Minh Quan
    Nguyen Quoc Minh
 ID:
    s3740934
    s3754450
    s3758994
 Created  date: 29/08/2022
 Last modified: 29/08/2022
 Acknowledgement:
 
 - https://www.youtube.com/watch?v=xXjYGamyREs&list=RDCMUCuP2vJ6kRutQBfRmdcI92mA&index=2
 */

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore

// MARK: Login View
struct LoginView: View {
    
    // MARK: - Properties
    let didCompleteLoginProcess: () -> ()
    @State var isLoginMode = true
    @State var email = ""
    @State var password = ""
    @State var changeView = false
    @State var shouldShowImagePicker = false
    
    // MARK: Image
    @State var image: UIImage?
    
    // MARK: - Body
    var body: some View {
        
        
            
            ZStack {
                
                
                // MARK: Background Image
                ZStack {
                    Image("login-background")
                        .resizable()
                        .frame(width: 500, height: 800)
                        .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea(.all)
                    
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: .black, location: 0),
                            .init(color: .black.opacity(0.2), location: 1)]),
                            startPoint: .bottom,
                            endPoint: .top
                    )
                    .ignoresSafeArea()
                }
                
                
        
            VStack (spacing: 16){
//                // MARK: - Choosing Login or Sign up
//                Picker(selection: $isLoginMode, label: Text("Picker here")) {
//                    Text("Login")
//                        .tag(true)
//                    Text("Create Account")
//                        .tag(false)
//                }.pickerStyle(SegmentedPickerStyle())
                
                // MARK: - User Image
                if !isLoginMode {
                    Button {
                        shouldShowImagePicker.toggle()
                    } label: {
                        VStack {
                            if let image = self.image {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 128, height: 128)
                                    .cornerRadius(64)
                            } else {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 64))
                                    .padding()
                                    .foregroundColor(Color(.label))
                            }
                        }
                        .overlay(RoundedRectangle(cornerRadius: 64)
                            .stroke(Color.black, lineWidth: 3)
                        )
                    }
                }
                
                Text("Login")
                    .foregroundColor(.white)
                    .font(.system(size: 42))
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                
                // MARK: - Text Field for email and password
                VStack (spacing: 18)  {
                    TextField("Email", text: $email)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .foregroundColor(.black)
                        .background(RoundedRectangle(cornerRadius: 4).fill(Color.white))
                        
                      
                    
                    SecureField("Password", text: $password)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .foregroundColor(.black)
                        .background(RoundedRectangle(cornerRadius: 4).fill(Color.white))
                       
                }
                .padding(.bottom, 10)
                .padding(.top, 20)
//                .padding(12)
//                .background(Color.white)
                
                // MARK: - Submit button
                Button {
                    handleAction()
                } label: {
                    HStack {
                        Spacer()
                        Text(isLoginMode ? "Enjoy your movie night!" : "Create Account")
                            .foregroundColor(.white)
                            .padding(.vertical, 16)
                            .font(.system(size: 16, weight: .bold))
                        Spacer()
                    }
                    
                    .background(Color("black"))
                    .border(.white, width:4)
                    .cornerRadius(2)
                    .opacity(0.85)
//                    .padding(.horizontal, 40)
                }.sheet(isPresented: $changeView) {
                    MainMessagesView()
                }
                
                HStack {
                    Text("New to Netflix?")
                    Text("Sign up")
                        
                }
               
                
                Text(self.loginStatusMessage)
                    .foregroundColor(.red)
            }
                .padding(.horizontal, 72)
                
            }
            .foregroundColor(.white)
            .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
                ImagePicker(image: $image)
            }
            
        
       
        
    }
    
    
    
    // MARK: Function handle login
    private func handleAction() {
        if isLoginMode {
            loginUser()
            print("Login Firebase with existing credentials")
        } else {
            CreateNewAccount()
            print("Register a new account")
        }
    }
    
    @State var loginStatusMessage = ""
    
    // MARK: Create New Account
    private func CreateNewAccount() {
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) {
            result, err in
            if let err = err {
                print ("Failed to create user:", err)
                self.loginStatusMessage = "Failed to create user: \(err)"
                return
            }
            
            print("Successsfully created user: \(result?.user.uid  ?? "")")
            
            self.loginStatusMessage = "Successsfully created user: \(result?.user.uid  ?? "")"
            
            self.persistImageToStorage()
        }
    }
    
    // MARK: Login Account
    private func loginUser() {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) {
            result, err in
            if let err = err {
                print ("Failed to login user:", err)
                self.loginStatusMessage = "Failed to login user: \(err)"
                return
            }
            
            print("Successsfully logged in as user: \(result?.user.uid  ?? "")")
            
            self.loginStatusMessage = "Successsfully logged in as user: \(result?.user.uid  ?? "")"
            
            self.didCompleteLoginProcess()
            //self.changeView.toggle()
            if let window = UIApplication.shared.windows.first {
                window.rootViewController = UIHostingController(rootView: Home())
                window.makeKeyAndVisible()
            }
        
            
        }
    }
    
    // MARK: Persist Image into Firebase Storage
    private func persistImageToStorage() {
        //        let filename = UUID().uuidString
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let ref = FirebaseManager.shared.storage.reference(withPath: uid)
        guard let imageData = self.image?.jpegData(compressionQuality: 0.5) else { return }
//        ref.putData(imageData, metadata: nil) { metadata, err in
        ref.putData(imageData, metadata: nil) { metadata, err in
            if let err = err {
                self.loginStatusMessage = "Failed to push image to Storage: \(err)"
                return
            }
            
            ref.downloadURL { url, err in
                if let err = err {
                    self.loginStatusMessage = "Failed to retrieve downloadURL: \(err)"
                    return
                }
                
                self.loginStatusMessage = "Successfully stored image with url: \(url?.absoluteString ?? "")"
//                print(url?.absoluteString)
                
                guard let url = url else {return }
                self.storeUserInformation(imageProfileUrl: url)
            }
        }
    }
    
    // MARK: Store User Information
    private func storeUserInformation(imageProfileUrl: URL) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let userData = ["email": self.email, "uid": uid, "profileImageUrl": imageProfileUrl.absoluteString]
        FirebaseManager.shared.firestore.collection("users")
            .document(uid).setData(userData) { err in
                if let err = err {
                    print(err)
                    self.loginStatusMessage = "\(err)"
                    return
                }

                print("Success")
                
                self.didCompleteLoginProcess()
            }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(didCompleteLoginProcess: {})
    }
}
