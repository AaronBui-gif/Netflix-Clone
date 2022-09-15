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

struct NavigationBar: View {
    
    // MARK: Properties
    @State var shouldShowLogOutOptions = false
    @State var shouldShowSearchView = false
    @State var saveList: [SaveList] = []
    @ObservedObject private var vm = MainMessagesViewModel()
    
    // MARK: BODY
    var body: some View {
        VStack{
            HStack(alignment: .center, spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Image("netflix")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60, alignment: .center)
                }

                Spacer()
                
//                // MARK: Screen Cast
//                NavigationLink{
//                    Home()
//                        .navigationBarTitle("")
//                        .navigationBarHidden(true)
//                        .navigationBarTitleDisplayMode(.inline)
//                } label: {
//                    Image("screen-cast")
//                        .resizable()
//                        .frame(width: 32, height: 30, alignment: .bottom)
//                        .foregroundColor(Color.white)
//                        .offset(x:0, y: 6)
//                }
                
                // MARK: - Search Bar
                NavigationLink{
                    SearchBarView()
                        .navigationBarTitle("")
                        .navigationBarHidden(false)
                        .navigationBarTitleDisplayMode(.inline)
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color.white)
                }
                
                

                //MARK: User Profile Picture
                NavigationLink{
                    ProfileSettingsView()
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                        .navigationBarTitleDisplayMode(.inline)
                } label: {
                    WebImage(url: URL(string: vm.chatUser?.profileImageUrl ?? ""))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 45)
                        .clipped()
                        .cornerRadius(15)
                    }
            }
            .padding(.bottom, 10)
            
            //MARK: - Menu Navigation
            HStack(alignment: .center, spacing: 70){
                //TV SHOWS
                NavigationLink{
                   HomeView(mainMessageViewModel: MainMessagesViewModel(), saveList: $saveList)
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                        .navigationBarTitleDisplayMode(.inline)
                } label: {
                        Text ("TV Shows")
                            .foregroundColor(Color.white)
                            .fontWeight(.semibold)
                }
                
                // MARK: Movies HOMEVIEW
                NavigationLink{
                    HomeView(mainMessageViewModel: MainMessagesViewModel(), saveList: $saveList)
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                        .navigationBarTitleDisplayMode(.inline)
                } label: {
                        Text ("Movies")
                            .foregroundColor(Color.white)
                            .fontWeight(.semibold)
                }
                
                //MARK: MOVIE LIST
                NavigationLink{
                    SaveListView()
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                        .navigationBarTitleDisplayMode(.inline)
                } label: {
                        Text ("My List")
                            .foregroundColor(Color.white)
                            .fontWeight(.semibold)
                }
            }
        }

    }
}

// MARK: Preview
struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar().preferredColorScheme(.dark)
    }
}
