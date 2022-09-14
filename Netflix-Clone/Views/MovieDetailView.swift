//
//  MovieDetailView.swift
//  Netflix-Clone
//
//  Created by Quan, Hoang Minh on 05/09/2022.
//

import SwiftUI

struct MovieDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var tabIndex = 0
    
    var movie: Movie
    
    var tabItems = [
        "Episodes", "Trailers", "Others"
    ]
    @ObservedObject var vm = MainMessagesViewModel()
    @State var showMovieInfo = false
    
    var body: some View {
        
        ZStack (alignment: .top) {
            Color.black.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 16){
                    VideoView(videoID: movie.youtubeID)
                        .frame(width: 370, height: 200, alignment: .center)
                     
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
                    
                    Text(movie.title)
                        .font(.system(size: 24))
                    .fontWeight(.bold)
                    Text(movie.welcomeDescription)
                    VStack(alignment: .center) {
                    HStack(alignment: .center, spacing: 0) {
                        Button{
                            
                        } label: {
                            HStack(alignment: .center, spacing: 20){
                                Image(systemName: "play.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20, alignment: .center)
                                    .foregroundColor(.black)
                                Text("Play")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                            }
                        }
                        .frame(width: 300, height:40, alignment: .center)
                        .background(Color.white)
                    }
                
                    HStack(alignment: .center, spacing: 0) {
                        Spacer()
                       
                        Button{
                            vm.putData(movieID: movie.movieID, title: movie.title)
                        } label: {
                            HStack(alignment: .center, spacing: 20){
                                Image(systemName: "square.and.arrow.down")
                                    .resizable()
                                    .frame(width: 20, height: 20, alignment: .center)
                                    .foregroundColor(.black)
                                Text("Add List")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                            }
                        }
                        .frame(width: 300, height:40)
                        .background(Color.gray)
                        Spacer()
                    }
                }
                    ScrollView(.horizontal) {
                        HStack(spacing: 12) {
                            ForEach(movie.castList.indices, id: \.self) { index in
                                VStack{
                                    Image(movie.castList[index].castImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 120, height: 130, alignment: .center)
                                    Text("\(movie.castList[index].castName)")
                                    
                                }
                            }
                        }
                    }
                    
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
                                        } else if (tabIndex == 1) {
                                            tabIndex = 2
                                        }
                                        else {
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

                        }
                    } else if (tabIndex == 1) {
                        VStack (alignment: .leading, spacing: 6) {
                            VideoView(videoID: movie.youtubeID)
                                .frame(width: 370, height: 200, alignment: .center)
                        }
                    }
                    else {
                        LazyVGrid(columns: [
                            GridItem(.flexible(minimum: 100, maximum: 200)),
                            GridItem(.flexible(minimum: 100, maximum: 200)),
                            GridItem(.flexible(minimum: 100, maximum: 200))
                        ], spacing: 25, content: {
                            ForEach(movies) { movie in
                                NavigationLink{
                                    MovieDetailView(movie: movie)
                                        .navigationBarTitle("")
                                        .navigationBarHidden(true)
                                        .navigationBarTitleDisplayMode(.inline)
                                } label: {
                                    HStack(alignment: .center){
                                        MovieRow(movie: movie)
                                }
                                }
                            }
                        })
                    }
                    
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(
                    leading:
                        HStack(alignment: .center){
                            //BACK BUTTON
                            CustomBackButtonView(action: {presentationMode.wrappedValue.dismiss()})
                            
                            Spacer()
                            
                            //IMAGE NETFLIX
                            Image("MainPage-logo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 124, height: 0, alignment: .center)
                            .ignoresSafeArea(.all)
                            .padding(.leading, -56)
                            
                            Spacer()

                        }
                        .frame(width: 390, height: 60, alignment: .center)
                        .background(LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: Color.black, location: 0),
                                .init(color: Color.black.opacity(1), location: 1)]),
                                startPoint: .top,
                                endPoint: .bottom).ignoresSafeArea(.all))
                )
                .foregroundColor(.white)
                .foregroundColor(.white)
            .padding(.horizontal, 16)
            }

            
        }
        
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: movies[0])
    }
}
