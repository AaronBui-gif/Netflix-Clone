//
//  MovieList.swift
//  RmitFlix
//
//  Created by Huy Bui Thanh on 19/07/2022.
//

import SwiftUI
import BottomSheet

struct MovieList: View {
    @State var showMovieInfo = false
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack(spacing: 15) {
                    NavigationBar()
                        .offset(y:13)
                    
                    ScrollView {
                        //VStack{
                        ZStack(alignment: .leading) {
                            LazyVGrid(columns: [
                                GridItem(.flexible(minimum: 100, maximum: 200)),
                                GridItem(.flexible(minimum: 100, maximum: 200)),
                                GridItem(.flexible(minimum: 100, maximum: 200))
                            ], spacing: 12, content: {
                                ForEach(movies) { movie in
                                    //                                    NavigationLink {
                                    //                                        MovieDetail(movie: movie)
                                    //                                    } label: {
                                    //                                        HStack(alignment: .center) {
                                    //                                            MovieRow(movie: movie)
                                    //                                        }
                                    //                                    }
                                    Button {
                                        showMovieInfo.toggle()
                                    } label: {
                                        HStack(alignment: .center) {
                                            MovieRow(movie: movie)
                                        }
                                    }
                                    .bottomSheet(isPresented: $showMovieInfo) {
                                        MovieDetailSummaryView(movie: movie)
                                    }
                                }
                            })
                        }.navigationBarTitle("Movies")
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarBackButtonHidden(true)
                        
                    } // Scroll View
                    .frame(minHeight:600, maxHeight: 7000)
                    NavigationBarLow()
                        .offset(y:17)
                    Image (systemName: "arrow.down.circle")
                    
                }
                
                .frame(maxHeight: .infinity, alignment: .top)
                
            }.navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationBarTitleDisplayMode(.inline)
       // }
        }
    }
}

struct MovieList_Previews: PreviewProvider {
    static var previews: some View {
        MovieList()
    }
    
}

