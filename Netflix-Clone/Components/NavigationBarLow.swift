//
//  NavigationBarLow.swift
//  Rmit (iOS)
//
//  Created by Huy Bui Thanh on 15/07/2022.
//

import SwiftUI

struct NavigationBarLow: View {
    
    // MARK: BODY
    @State var saveList: [SaveList] = []
    var body: some View {
        VStack{
            HStack(alignment: .bottom, spacing: 73) {
                
                // MARK: Home Button
                NavigationLink{
                    HomeView(mainMessageViewModel: MainMessagesViewModel(), saveList: $saveList)
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                    .navigationBarTitleDisplayMode(.inline)} label: {
                        VStack {
                            Image (systemName: "house")
                                .font(.title2.bold())
                                .foregroundColor(Color.white)
                            Text("Menu")
                                .fontWeight(.semibold)
                                .font(.system(size: 13))
                                .foregroundColor(Color.white)
                        }
                    }
                
                // MARK: Comming Soon Button
                
                NavigationLink{
                    ComingSoonView()
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                        .navigationBarTitleDisplayMode(.inline)
                }
            label: {
                VStack {
                    Image (systemName: "play.rectangle.on.rectangle")
                        .font(.title2.bold())
                        .foregroundColor(Color.white)
                    Text("Coming Soon")
                        .fontWeight(.semibold)
                        .font(.system(size: 13))
                        .foregroundColor(Color.white)
                }
            }
                
                // MARK: Downloads button
                NavigationLink{}
            label: {
                VStack {
                    Image (systemName: "arrow.down.circle")
                        .font(.title2.bold())
                        .foregroundColor(Color.white)
                    Text("Downloads")
                        .fontWeight(.semibold)
                        .font(.system(size: 13))
                        .foregroundColor(Color.white)
                }
            }
                
            }
        }
    }
}

// MARK: Preview
struct NavigationBarLow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarLow().preferredColorScheme(.dark)
    }
}
