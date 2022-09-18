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
import Foundation

struct HomeView: View {
    
    // MARK: Properties
    @State var showMovieInfo = false
    @Environment(\.dismiss) var dismiss
    @ObservedObject var mainMessageViewModel: MainMessagesViewModel
    @Binding var saveList: [SaveList]
    // MARK: BODY
    var body: some View {
        
        //MARK: - Navigation View
        NavigationView{
            ZStack{
                // MARK: Background COlor
                Color.black.ignoresSafeArea()
                
                // MARK: MAIN CONTENT
                ScrollView (showsIndicators: false){
                    VStack(spacing: 0){
                        NavigationLink{ MovieDetailView(movie: movies[0])} label: {
                            ZStack{
                                
                                // MARK: First item
                                Image(movies[0].imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 390, height: 552)
                             
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
                        .offset(x: 0, y : -40)
                        .overlay(
                            VStack{
                                //MARK: - NAVIGATION BAR
                                NavigationBar()
                                    .padding(.top, 28)
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
                        )
                        
                        
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
                        Group{
                        // MARK: New release movies
                        MovieCarouselView(secionTitle: "New Release")
                        ZStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                ScrollView(.horizontal) {
                                    HStack(spacing: 12) {
                                        ForEach(popularMovies, id:\.self) { popular in
                                            NavigationLink{
                                                MovieDetailView(movie: popular)
                                            } label: {
                                                MovieRow(movie: popular)
                                            }
                                        }
                                        
                                    }
                                }
                            }
                            .padding(8)
                        } .offset(y:-20)
                        
                        // MARK: Romance movies
                        MovieCarouselView(secionTitle: "Romance")
                        ZStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                ScrollView(.horizontal) {
                                    HStack(spacing: 12) {
                                        ForEach(romanceMovies, id:\.self) { romance in
                                            NavigationLink{
                                                MovieDetailView(movie: romance)
                                            } label: {
                                                MovieRow(movie: romance)
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(8)
                        } .offset(y:-20)
                        
                        // MARK: Horror movies
                        MovieCarouselView(secionTitle: "Horror")
                        ZStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                ScrollView(.horizontal) {
                                    HStack(spacing: 12) {
                                        ForEach(horrorMovies, id:\.self) { horror in
                                            NavigationLink{
                                                MovieDetailView(movie: horror)
                                            } label: {
                                                MovieRow(movie: horror)
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(8)
                        } .offset(y:-20)
                        
                        // MARK: Action movies
                        MovieCarouselView(secionTitle: "Action")
                        ZStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                ScrollView(.horizontal) {
                                    HStack(spacing: 12) {
                                        ForEach(actionMovies, id:\.self) { action in
                                            NavigationLink{
                                                MovieDetailView(movie: action)
                                            } label: {
                                                MovieRow(movie: action)
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(8)
                        } .offset(y:-20)
                        
                        // MARK: Thriller movies
                        MovieCarouselView(secionTitle: "Thriller")
                        ZStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                ScrollView(.horizontal) {
                                    HStack(spacing: 12) {
                                        ForEach(thrillerMovies, id:\.self) { thriller in
                                            NavigationLink{
                                                MovieDetailView(movie: thriller)
                                            } label: {
                                                MovieRow(movie: thriller)
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(8)
                        } .offset(y:-20)
                        }
                        
                        // MARK: Comedy movies
                        MovieCarouselView(secionTitle: "Comedy")
                        ZStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                ScrollView(.horizontal) {
                                    HStack(spacing: 12) {
                                        ForEach(comedyMovies, id:\.self) { comedy in
                                            NavigationLink{
                                                MovieDetailView(movie: comedy)
                                            } label: {
                                                MovieRow(movie: comedy)
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(8)
                        }.offset(y:-20)
                        
                        // MARK: Sci-Fic movies
                        MovieCarouselView(secionTitle: "Science Fiction")
                        ZStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                ScrollView(.horizontal) {
                                    HStack(spacing: 12) {
                                        ForEach(scificMovies, id:\.self) { scific in
                                            NavigationLink{
                                                MovieDetailView(movie: scific)
                                            } label: {
                                                MovieRow(movie: scific)
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(8)
                        }.offset(y:-20)
                    }
                   
                    
                }//ScrolView
                .frame(minHeight:600, maxHeight: 7000)
                
                   
                // Main content ends
            }//ZStack
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
            
            
        }//NavigationView
        
    }
}
