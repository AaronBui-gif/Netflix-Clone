//
//  NavigationBar.swift
//  Rmit (iOS)
//
//  Created by Huy Bui Thanh on 15/07/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct NavigationBar: View {
    // MARK: Properties
    @State var shouldShowLogOutOptions = false
    @State var shouldShowSearchView = false
    @ObservedObject private var vm = MainMessagesViewModel()
    
    // MARK: Body
    var body: some View {
        VStack{
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Image("netflix")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60, alignment: .center)
                }
                Spacer()
                
                // MARK: Search Bar
                NavigationLink{ Home().navigationBarTitle("")
                        .navigationBarHidden(true)
                    .navigationBarTitleDisplayMode(.inline)} label: {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color.white)
                    }
                // MARK: User Profile Picture
                NavigationLink{ Home().navigationBarTitle("")
                        .navigationBarHidden(true)
                    .navigationBarTitleDisplayMode(.inline)} label: {
                        WebImage(url: URL(string: vm.chatUser?.profileImageUrl ?? ""))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 45)
                            .clipped()
                            .cornerRadius(15)
                    }
            }
            
            
            HStack(spacing: 90){
                NavigationLink{ Home().navigationBarTitle("")
                        .navigationBarHidden(true)
                    .navigationBarTitleDisplayMode(.inline)} label: {
                        Text ("TV Shows")
                            .foregroundColor(Color.white)
                    }
                NavigationLink{ Home().navigationBarTitle("")
                        .navigationBarHidden(true)
                    .navigationBarTitleDisplayMode(.inline)} label: {
                        Text ("Movies")
                            .foregroundColor(Color.white)
                    }
                NavigationLink{ Home().navigationBarTitle("")
                        .navigationBarHidden(true)
                    .navigationBarTitleDisplayMode(.inline)} label: {
                        Text ("My List")
                            .foregroundColor(Color.white)
                    }
            }
        }


    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar().preferredColorScheme(.dark)
    }
}
