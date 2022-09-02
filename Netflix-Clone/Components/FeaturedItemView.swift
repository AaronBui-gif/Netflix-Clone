//
//  FeatureItemView.swift
//  group
//
//  Created by minh on 9/1/22.
//

import SwiftUI

struct FeaturedItemView: View {
    var image:String = "MainPage-background1"
    
    var body: some View {
//        ZStack{
            Image(image)
                .resizable()
                .frame(maxWidth: 390)

            
//            LinearGradient(
//                gradient: Gradient(stops: [
//                    .init(color: Color.black, location: 0),
//                    .init(color: Color.black.opacity(0.25), location: 1)]),
//                    startPoint: .bottom,
//                    endPoint: .top)
//        }
//        .ignoresSafeArea()

    }
}

struct FeaturedItemView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedItemView(image: "MainPage-background1")
    }
}
