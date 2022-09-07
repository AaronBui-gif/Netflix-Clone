//
//  MovieDetailSummaryView.swift
//  Netflix-Clone
//
//  Created by Huy Bui Thanh on 07/09/2022.
//

import SwiftUI

struct MovieDetailSummaryView: View {
    var movie: Movie
    var body: some View {
        ZStack{
            Color.gray.ignoresSafeArea()
            HStack{
                Text(movie.title)
                VStack {
                    Text(movie.title)
                }
            }
        }
    }
}

struct MovieDetailSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailSummaryView(movie: movies[0])
    }
}
