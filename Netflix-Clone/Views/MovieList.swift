//
//  MovieList.swift
//  RmitFlix
//
//  Created by Huy Bui Thanh on 19/07/2022.
//

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
                    
                    // MARK: Navigation Bar Low
                    NavigationBarLow()
                        .offset(y:17)
                    Image (systemName: "arrow.down.circle")
                    
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

