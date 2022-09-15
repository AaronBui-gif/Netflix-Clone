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

struct MovieList: View {
    
    // MARK: Properties
    @State var showMovieInfo = false
    
    // MARK: BODY
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack(spacing: 15) {
                    
                    // MARK: Navigation Bar
                    NavigationBar()
                        .offset(y:13)
                    
                    // MARK: MAIN CONTENT
                    ScrollView {
                        //VStack{
                        ZStack(alignment: .leading) {
                            LazyVGrid(columns: [
                                GridItem(.flexible(minimum: 100, maximum: 200)),
                                GridItem(.flexible(minimum: 100, maximum: 200)),
                                GridItem(.flexible(minimum: 100, maximum: 200))
                            ], spacing: 12, content: {
                                ForEach(popularMovies, id:\.self) { movie in
                                    // MARK: Displaying MOVIES
                                    NavigationLink{
                                        MovieDetailView(movie: movie)
                                    } label: {
                                            MovieRow(movie: movie)
                                    }
                                    
                                }
                            })
                        }.navigationBarTitle("Movies")
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarBackButtonHidden(true)
                        
                    } // Scroll View
                    .frame(minHeight:600, maxHeight: 7000)

                    
                }
                
                .frame(maxHeight: .infinity, alignment: .top)
                
            }.navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: Preview
struct MovieList_Previews: PreviewProvider {
    static var previews: some View {
        MovieList()
    }
    
}

