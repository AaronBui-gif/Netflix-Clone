//
//  MovieRow.swift
//  Rmit
//
//  Created by Huy Bui Thanh on 19/07/2022.
//

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
