//
//  NavigationBar2.swift
//  Netflix-Clone
//
//  Created by Huy Bui Thanh on 30/08/2022.
//

import SwiftUI

struct NavigationBar2: View {
    var body: some View {
        HStack(spacing: 100){
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

struct NavigationBar2_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar2().preferredColorScheme(.dark)
    }
}
