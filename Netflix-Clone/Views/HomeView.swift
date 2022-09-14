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
                        } .offset(y:20)
                        
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
                        } .offset(y:20)
                    }
                    
                }
                
//                // MARK: Fetching saved list
//                .onAppear(){
//                    mainMessageViewModel.fetch()
//                }
                .ignoresSafeArea()
                //.padding(.top, -90)
                // Main content ends
                
                
            }//ZStack
//            // MARK: Fetching saved list
//            .onAppear(){
//                
//                mainMessageViewModel.fetch()
//            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
            
            
        }//NavigationView
        
    }
}

//// MARK: Preview
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//       HomeView(mainMessageViewModel: MainMessagesViewModel(), saveList: SaveList)
//    }
//}
