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

// MARK: Displaying Movie Card
struct MovieRow: View {
    
    // MARK: Properties
    var movie: Movie
    
    // MARK: BODY
    var body: some View {
        //Display image for movie
        movie.image
            .resizable()
            .frame(width: 120, height: 200)
            .cornerRadius(20)

    }
}

// MARK: Preview
struct MovieRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MovieRow(movie: movies[0])
            //MovieRow(movie: movies[1])
        }
        .previewLayout(.fixed(width: 550, height: 600))
        
    }
}
