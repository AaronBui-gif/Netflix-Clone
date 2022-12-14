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
import SDWebImageSwiftUI

struct ProfileSettingsView: View {
    
    // MARK: Properties
    @State var shouldShowLogOutOptions = false
    @State var email = ""
    @ObservedObject private var vm = MainMessagesViewModel()
    
    @Environment(\.presentationMode) var presentationMode:
    Binding <PresentationMode>
    
    // MARK: Custom Navigation Bar
    var BackButton: some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        HStack{
            Image(systemName: "arrow.backward")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
            Text("Profile & Other Contents")
                .foregroundColor(.white)
        }
    }
    }
    
    // MARK: BODY
    var body: some View {
        NavigationView{
            ZStack{
                Color.black.ignoresSafeArea()
                VStack(spacing: 30) {
                    
                    // MARK: User Profile Picture
                    WebImage(url: URL(string: vm.chatUser?.profileImageUrl ?? ""))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipped()
                        .cornerRadius(20)
                     
                    // MARK: Email
                    let email = vm.chatUser?.email.replacingOccurrences(of: "@gmail.com", with: "") ?? ""
                    
                    Text("\(email)")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .frame(alignment:.center)
                    
                    // MARK: Manage Accounts
                    NavigationLink{ ManageAccountView().navigationBarTitle("")
                            .navigationBarHidden(true)
                        .navigationBarTitleDisplayMode(.inline)} label: {
                            HStack {
                                Image(systemName: "pencil")
                                    .foregroundColor(.gray)
                                Text("Manage Account")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.gray)
                            }
                        }
                    
                    // MARK: Movie List
                    NavigationLink{  SaveListView().navigationBarTitle("")
                            .navigationBarHidden(true)
                        .navigationBarTitleDisplayMode(.inline)} label: {
                            HStack {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.gray)
                                Text("Movie List")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.gray)
                            }
                        }
                    
                    // MARK: Setting
                    NavigationLink{ } label: {
                        HStack {
                            Text("Setting")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.gray)
                        }
                    }
                    
                    // MARK: Account
                    NavigationLink{ } label: {
                        HStack {
                            Text("Account")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.gray)
                        }
                    }
                    
                    // MARK: Help
                    NavigationLink{ } label: {
                        HStack {
                            Text("Help")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.gray)
                        }
                    }
                    
                    // MARK: Log out
                    Button {
                        shouldShowLogOutOptions.toggle()
                    } label: {
                        Text("Sign Out")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.gray)
                    }
                }       .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
                    .actionSheet(isPresented: $shouldShowLogOutOptions) {
                        .init(title: Text("Settings"), message: Text("What do you want to do?"), buttons: [
                            .destructive(Text("Sign Out"), action: {
                                print("handle sign out")
                                vm.handleSignOut()
                            }),
                            .cancel()
                        ])
                    }
                
                // MARK: User Log Out Sheet
                    .fullScreenCover(isPresented: $vm.isUserCurrentlyLoggedOut, onDismiss: nil) {
                        LoginView(mainMessageViewModel: MainMessagesViewModel(), didCompleteLoginProcess: {
                            self.vm.isUserCurrentlyLoggedOut = false
                            self.vm.fetchCurrentUser()
                        })
                    }
                
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton)
        }
    }
}

// MARK: Preview
struct ProfileSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSettingsView()
    }
}
