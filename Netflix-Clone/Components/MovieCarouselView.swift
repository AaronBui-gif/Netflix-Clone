//
//  MovieCarouselView.swift
//  Netflix-Clone
//
//  Created by Hue Pham on 03/09/2022.
//

import SwiftUI

struct MovieCarouselView: View {
    var secionTitle : String = "New Release"
    var listData = "samples"
    var aspect = 0.70
    var body: some View {
        VStack (alignment: .leading, spacing: 6){
            Text(secionTitle)
                .font(.system(size: 26))
                .fontWeight(.bold)
                .padding(.leading, 4)
            
            ScrollView (.horizontal) {
                HStack(spacing: 8) {
                    ForEach(samples, id:\.self){movie in
                        MovieCardView(imageName: movie.imageName, aspect: aspect)
                    }
                }
            }
            .padding(.leading, 6)
        }
        .foregroundColor(.white)
    }
}

struct MovieCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCarouselView()
            .background(Color.blue)
    }
}
