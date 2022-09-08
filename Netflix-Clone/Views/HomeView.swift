//
//  HomeView.swift
//  Netflix-Clone
//
//  Created by Hue Pham on 02/09/2022.
//

import SwiftUI
import Foundation
import BottomSheet

struct HomeView: View {
    @State var showMovieInfo = false
    var body: some View {
        //MARK - Navigation View
        NavigationView{
            ZStack{
                Color.black.ignoresSafeArea()
                
                // Main content begins
                ScrollView{
                    VStack(spacing: 0){
                        //Header
                        ZStack {
                            NavigationLink{ MovieDetail(movie: movies[0])} label: {
                                    ZStack{
                                        Image(movies[0].imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 390, height: 552)
//                                        .scaledToFill()
//                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
                                        .opacity(0.65)
                                        .ignoresSafeArea(.all)
                                        
                                        LinearGradient(
                                            gradient: Gradient(stops: [
                                                .init(color: .black, location: 0),
                                                .init(color: .black.opacity(0.1), location: 0.35)]),
                                                startPoint: .bottom,
                                                endPoint: .top
                                        )
                                    .ignoresSafeArea()
                                    }
                            }
                                
                                VStack{
                                    //MARK: - NAVIGATION BAR
                                    NavigationBar()
                                        .padding(.top, 42)
                                    Spacer()
                                    
                                    //MARK: - CATEGORY/TYPE OF MOVIE
                                    HStack{
                                        Text("Anime")
                                            .font(.system(size: 18))
                                            .foregroundColor(.white)
                                            .fontWeight(.semibold)
    
                                        
                                        Image("dot")
                                            .resizable()
                                            .frame(width: 6, height: 6, alignment: .center)
                                        
                                        Text("Fantasy")
                                            .font(.system(size: 18))
                                            .foregroundColor(.white)
                                            .fontWeight(.medium)
                                        
                                        Image("dot")
                                            .resizable()
                                            .frame(width: 6, height: 6, alignment: .center)
                                        
                                        Text("Mystery")
                                            .font(.system(size: 18))
                                            .foregroundColor(.white)
                                            .fontWeight(.medium)
                                    }
                                }
                            }
                        
                    }
                    .padding(.bottom, 0)
                    //Main content ends
                    
                    //MARK: - MyList + Play + Info buttons
                    HStack(alignment: .center, spacing: 60){
                        
                        //MY LIST BUTTON
                        Button(action: {
                            //myList.append(movies[1])
                            //print(myList)
                        }) {
                            VStack{
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 20, height: 20, alignment: .center)
                                    .foregroundColor(.white)
                                Text("My List")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                            }.padding(.top, 4)
                        }
                        
                        //PLAY BUTTON
                        Button{
                            
                        } label: {
                            HStack(alignment: .center, spacing: 18){
                                Image(systemName: "play.fill")
                                    .resizable()
                                    .frame(width: 18, height: 18, alignment: .center)
                                    .foregroundColor(.black)
                                Text("Play")
                                    .font(.system(size: 18))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                            }
                            .padding(.leading, 4)
                        }
                        .frame(width: 110, height:38)
                        .background(Color.white)
                        
                        //INFO BUTTON
                        Button{
                            
                        } label: {
                            VStack{
                                Image(systemName: "info.circle")
                                    .resizable()
                                    .frame(width: 24, height: 24, alignment: .center)
                                    .foregroundColor(.white)
                                Text("Info")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                            }.padding(.top, 10)
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 4))
                    
                    //MARK: - BODY
                    VStack (spacing: 24){
                        MovieCarouselView(secionTitle: "New Release")
                        ZStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                ScrollView(.horizontal) {
                                    HStack(spacing: 12) {
                                        ForEach(popularMovies, id:\.self) { popular in
                                            Button {
                                                showMovieInfo.toggle()
                                            } label: {
//                                            NavigationLink{ MovieDetailView(movie: popular)} label: {
                                                Image(popular.imageName)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 200)
                                                    .cornerRadius(12)

                                            }.bottomSheet(isPresented: $showMovieInfo) {
                                                MovieDetailSummaryView(movie: popular)
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(8)
                        } .offset(y:20)
                        MovieCarouselView(secionTitle: "Romance")
                        ZStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                ScrollView(.horizontal) {
                                    HStack(spacing: 12) {
                                        ForEach(romanceMovies, id:\.self) { romance in
                                            Button {
                                                showMovieInfo.toggle()
                                            } label: {
//                                            NavigationLink{ MovieDetailView(movie: popular)} label: {
                                                Image(romance.imageName)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 200)
                                                    .cornerRadius(12)

                                            }.bottomSheet(isPresented: $showMovieInfo) {
                                                MovieDetailSummaryView(movie: romance)
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(8)
                        } .offset(y:20)
                    }

                }//.ignoresSafeArea(.all)
                //.padding(.top, -90)
                // Main content ends

                
            }//ZStack
            
            
        }//NavigationView
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
