//
//  NavigationBarLow.swift
//  Rmit (iOS)
//
//  Created by Huy Bui Thanh on 15/07/2022.
//

import SwiftUI

struct NavigationBarLow: View {
    var body: some View {
        
        
        VStack{
            HStack(alignment: .bottom, spacing: 73) {
                
                // Home Button
                NavigationLink{
                    HomeView()
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
                
                // Comming Soon Button
                
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
                
                // Downloads button
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

struct NavigationBarLow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarLow().preferredColorScheme(.dark)
    }
}
