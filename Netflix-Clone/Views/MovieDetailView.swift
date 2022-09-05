//
//  MovieDetailView.swift
//  Netflix-Clone
//
//  Created by Quan, Hoang Minh on 05/09/2022.
//

import SwiftUI

struct MovieDetailView: View {
    @State var tabIndex = 0
    var title = "Movie Title"
    var description = "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
    
    
    
    private var tabItems = [
        "Description", "Others"
    ]
    var body: some View {
        
        ZStack (alignment: .top) {
            Color.black.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 16){
                    Rectangle().fill(Color.red)
                        .frame(height: 200)
                    
                    // Save to List button SAVE TO LIST BUTTON
                    HStack (alignment: .center, spacing: 28) {
                        VStack (spacing: 4){
                            Image(systemName: "plus")
                                .font(.system(size: 20))
                            Text("Save to My List")
                                .font(.system(size: 14))
                                .foregroundColor(Color.gray)
                        }
                        
                        VStack (spacing: 4){
                            Image(systemName: "hand.thumbsup")
                            Text("Ranking")
                                .font(.system(size: 14))
                                .foregroundColor(Color.gray)
                        }
                        
                        VStack (spacing: 4){
                            Image(systemName: "arrowshape.turn.up.right")
                                .font(.system(size: 20))
                            Text("Share")
                                .font(.system(size: 14))
                                .foregroundColor(Color.gray)
                        }
                       
                    }
                    .padding(.top, 8)
                    
                    VStack (alignment: .leading, spacing: 0) {
                        Rectangle().fill(Color.gray)
                            .frame(height: 0.5)
                        
                        HStack{
                            ForEach(Array(tabItems.enumerated()), id:\.offset){index, tab in
                                VStack(alignment: .leading) {
                                    
                                
                                    Rectangle().fill(tabIndex == index ? Color.red : Color.red.opacity(0))
                                    .frame(width: tabIndex == 0 ? 100 : 60 ,height: 2)
                                    
                                    Text(tab)
                                }
                                .onTapGesture {
                                    withAnimation(.linear(duration: 0.1)) {
                                        if (tabIndex == 0){
                                            tabIndex = 1
                                        }else {
                                            tabIndex = 0
                                        }
                                    }
                                }
                                
                            }
                        }
                    }
                    
                    
                    
                    // Tab content
                    if (tabIndex == 0){
                        // Movie description
                        VStack (alignment: .leading, spacing: 6) {
                            Text("About \(title)")
                                .font(.system(size: 24))
                            .fontWeight(.bold)
                            Text(description)
                        }
                    }else {
                        LazyVGrid(columns: [
                            GridItem(.flexible(minimum: 100, maximum: 200)),
                            GridItem(.flexible(minimum: 100, maximum: 200)),
                            GridItem(.flexible(minimum: 100, maximum: 200))
                        ], spacing: 12, content: {
                            ForEach(samples) { movie in
                                NavigationLink {
                                    MovieDetailView()
                                } label: {
                                    HStack(alignment: .center) {
                                        MovieCardView(imageName: movie.imageName)
                                    }
                                }
                            }
                        })
                    }
                    
                    
                    
                }
                .foregroundColor(.white)
            .padding(.horizontal, 16)
            }
            
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView()
    }
}
