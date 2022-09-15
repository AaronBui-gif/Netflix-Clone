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
//                    ForEach(samples, id:\.self){movie in
//                        MovieCardView(imageName: movie.imageName, aspect: aspect)
//                    }
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
