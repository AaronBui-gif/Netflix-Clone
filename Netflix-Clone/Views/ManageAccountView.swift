/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Author: Bui Thanh Huy
 ID: s3740934
 Created  date: 29/08/2022
 Last modified: 29/08/2022
 Acknowledgement:
 
 - https://www.youtube.com/watch?v=xXjYGamyREs&list=RDCMUCuP2vJ6kRutQBfRmdcI92mA&index=2
 */
import SwiftUI
import SDWebImageSwiftUI
import FirebaseFirestore

struct ManageAccountView: View {
    
    // MARK: Properties
    @State var shouldShowLogOutOptions = false
    @State var shouldSave = false
    @State var newEmail = ""
    @State var saveStatusMessage = ""
    @State var shouldShowImagePicker = false
    @State var saveList: [SaveList] = []
    // MARK: Image
    @State var image: UIImage?
    @ObservedObject private var vm = MainMessagesViewModel()
    
    
    @Environment(\.presentationMode) var presentationMode:
    Binding <PresentationMode>
    
    // MARL: Custom Navigation Bar
    var BackButton: some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        HStack{
            Image(systemName: "arrow.backward")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
            Text("Manage Accounts")
                .foregroundColor(.white)
        }
    }
    }
        //.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
    
    
    // MARK: Body
    var body: some View {
        NavigationView{
            ZStack{
                Color.black.ignoresSafeArea()
                VStack(spacing: 15) {
                    
                    // MARK: User Profile Picture
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
                                    WebImage(url: URL(string: vm.chatUser?.profileImageUrl ?? ""))
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .clipped()
                                        .cornerRadius(20)
                                }
                            }

                        }
                    
                    // MARK: Email
                    let email = vm.chatUser?.email.replacingOccurrences(of: "@gmail.com", with: "") ?? ""
                    
                    TextField("\(email)", text: $newEmail)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .frame(width: 200, alignment: .center)
                        .foregroundColor(Color.red)
                        .background(Color.white)
                    
                    Spacer()
                        .frame(height:20)
                    // MARK: Display Age Restriction
                    ZStack{
                        Rectangle()
                            .fill(.gray)
                            .frame(width: 110, height: 40, alignment: .center)
                        Text("ALL AGE")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                    }
                    
                    // MARK: Information Age Restriction
                    Text("Display all movies or shows for all age on this profile")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.gray)
                        .frame(alignment:.center)
                    
                    // MARK: - Submit button
                    Button {
                        persistImageToStorage()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Save")
                                .foregroundColor(.green)
                                .padding(.vertical, 10)
                                .font(.system(size: 14, weight: .semibold))
                            Spacer()
                        } .background(Color.blue)
                    }
                    
                    // MARK: - Submit button
                    Button {
                        deleteUser()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Delete")
                                .foregroundColor(.red)
                                .padding(.vertical, 10)
                                .font(.system(size: 14, weight: .semibold))
                            Spacer()
                        } .background(Color.blue)
                    }
                    Text(self.saveStatusMessage)
                        .foregroundColor(.red)
                }
                
                
                
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            }.navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: BackButton)
                .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
                    ImagePicker(image: $image)
                }
        }
    }
    
    // MARK: Persist Image into Firebase Storage
    private func persistImageToStorage() {
        if self.image == nil {
            self.saveStatusMessage = "You must select an avatar image"
            return
        }
        
        if self.newEmail == "" {
            self.saveStatusMessage = "You must change your name"
            return
        }
        //        let filename = UUID().uuidString
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let ref = FirebaseManager.shared.storage.reference(withPath: uid)
        guard let imageData = self.image?.jpegData(compressionQuality: 0.5) else { return }
//        ref.putData(imageData, metadata: nil) { metadata, err in
        ref.putData(imageData, metadata: nil) { metadata, err in
            if let err = err {
                self.saveStatusMessage = "Failed to push image to Storage: \(err)"
                return
            }
            
            ref.downloadURL { url, err in
                if let err = err {
                    self.saveStatusMessage = "Failed to retrieve downloadURL: \(err)"
                    return
                }
                
                self.saveStatusMessage = "Successfully stored image with url: \(url?.absoluteString ?? "")"
                //print(url?.absoluteString)
                
                guard let url = url else {return }
                self.saveInfo(imageProfileUrl: url)
            }
        }
    }
    
    // MARK: Save Info Function
    private func saveInfo(imageProfileUrl: URL) {
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let userData = ["email": self.newEmail, "uid": uid, "profileImageUrl": imageProfileUrl.absoluteString]
        FirebaseManager.shared.firestore.collection("users")
            .document(uid).updateData(userData) { err in
                if let err = err {
                    print(err)
                    self.saveStatusMessage = "\(err)"
                    return
                }

                print("Success")
                if let window = UIApplication.shared.windows.first {
                    window.rootViewController = UIHostingController(rootView: HomeView(mainMessageViewModel: MainMessagesViewModel(), saveList: $saveList))
                    window.makeKeyAndVisible()
                }
            }
    }
    
    // MARK: Delete User Function
    private func deleteUser() {
        //guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        FirebaseManager.shared.auth.currentUser?.delete() { err in
                if let err = err {
                    print(err)
                    self.saveStatusMessage = "\(err)"
                    return
                }
                print("Success")
                if let window = UIApplication.shared.windows.first {
                    window.rootViewController = UIHostingController(rootView: LoginView(mainMessageViewModel: MainMessagesViewModel(),didCompleteLoginProcess: {}))
                    window.makeKeyAndVisible()
                }
            }
    }
}

// MARK: Preview
struct ManageAccountView_Previews: PreviewProvider {
    static var previews: some View {
        ManageAccountView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
            .previewDisplayName("iPhone 13")
        
        ManageAccountView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
            .previewDisplayName("iPhone 13 Pro Max")
    }
}
