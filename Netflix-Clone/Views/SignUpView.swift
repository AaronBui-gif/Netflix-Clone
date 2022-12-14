/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Author:
    Bui Thanh Huy
    Hoang Minh Quan
    Nguyen Quoc Minh
    Pham Huynh Ngoc Hue
 ID:
    s3740934
    s3754450
    s3758994
    s3702554
 Created  date: 29/08/2022
 Last modified: 29/08/2022
 Acknowledgement:
 
 - https://www.youtube.com/watch?v=xXjYGamyREs&list=RDCMUCuP2vJ6kRutQBfRmdcI92mA&index=2
 */
import SwiftUI

struct SignUpView: View {
    
    // MARK: - Properties
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let didCompleteLoginProcess: () -> ()
    @State var isLoginMode = true
    @State var email = ""
    @State var password = ""
    @State var changeView = false
    @State var shouldShowImagePicker = false
    
    @State var loginStatusMessage = ""
    // MARK: Image
    @State var image: UIImage?
    
    // MARK: Observed Object
    @ObservedObject var mainMessageViewModel: MainMessagesViewModel
    
    // MARK: - BODY
    var body: some View {
            ZStack {
                
                // MARK: Background Image
                ZStack {
                    
                    Color.black.ignoresSafeArea()
                    Image("login-background")
                        .resizable()
                        .frame(width: 500, height: 800)
                        .aspectRatio(contentMode: .fill)
                        .offset(x: 0, y: 30)
                    
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
                
            
                // MARK: - User Image
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
                                .font(.system(size: 36))
                                .padding()
                                .foregroundColor(Color(.white))
                        }
                    }
                    .overlay(RoundedRectangle(cornerRadius: 64)
                        .stroke(Color.white, lineWidth: 3)
                    )
                }

                
                //Title
                Text("Sign Up")
                    .font(.system(size: 42))
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                
                //MARK: - Text Field for email and password
                VStack (spacing: 18)  {
                    Text("Email")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .padding(.trailing, 265.0)
                    
                    TextField("Email", text: $email)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 20)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .foregroundColor(.black)
                        .background(RoundedRectangle(cornerRadius: 2).fill(Color.white))
                        .padding(.bottom, 20)
                    
                    Text("Password")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .padding(.trailing, 215.0)
                    
                    SecureField("Password", text: $password)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 20)
                        .foregroundColor(.black)
                        .background(RoundedRectangle(cornerRadius: 2).fill(Color.white))
                        .padding(.bottom, 10)
                       
                }
                .padding(.bottom, 20)
                .padding(.top, 20)
                
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

                }
                
                HStack {
                    Text("Already a member?")
                    
                    // MARK: Login
                    NavigationLink{
                        LoginView(mainMessageViewModel: MainMessagesViewModel(), didCompleteLoginProcess: {})
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                        .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        Text("Login")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        }
                        
                }
               
                
                Text(self.loginStatusMessage)
                    .foregroundColor(.red)
            }
                .padding(.horizontal, 80)
                
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading:
                    HStack(alignment: .center){
                        //BACK BUTTON
                        CustomBackButtonView(action: {presentationMode.wrappedValue.dismiss()})
                        
                        Spacer()
                        
                        //IMAGE NETFLIX
                        Image("MainPage-logo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 124, height: 0, alignment: .center)
                        .ignoresSafeArea(.all)
                        .padding(.leading, -56)
                        
                        Spacer()

                    }
                    .frame(width: 390, height: 60, alignment: .center)
                    .background(LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: Color.black, location: 0),
                            .init(color: Color.black.opacity(1), location: 1)]),
                            startPoint: .top,
                            endPoint: .bottom).ignoresSafeArea(.all))
            )
            .foregroundColor(.white)
            .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
                ImagePicker(image: $image)
            }
    }
    
    // MARK: Function handle login
    private func handleAction() {
        CreateNewAccount()
        print("Register a new account")
    }
    
    // MARK: Create New Account
    private func CreateNewAccount() {
        if self.image == nil {
            self.loginStatusMessage = "You must select an avatar image"
            return
        }
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
            mainMessageViewModel.makePostRequest(name: email, pass: password)
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
                //print(url?.absoluteString)
                
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


// MARK: Preview
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(didCompleteLoginProcess: {}, mainMessageViewModel: MainMessagesViewModel())
    }
}
