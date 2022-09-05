//
//  MovieCardView.swift
//  Netflix-Clone
//
//  Created by Hue Pham on 03/09/2022.
//

import SwiftUI

struct MovieCardView: View {
    
    var imageName : String = "picture2"
    var aspect : CGFloat = 0.75
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(aspect, contentMode: .fit)
            .frame(width: 150)
            .cornerRadius(12)
    }
}

struct MovieCardView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCardView()
    }
}
