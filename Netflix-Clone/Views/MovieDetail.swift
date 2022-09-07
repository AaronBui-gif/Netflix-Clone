//
//  MovieDetail.swift
//  RmitFlix
//
//  Created by Huy Bui Thanh on 19/07/2022.
//

import SwiftUI


struct MovieDetail: View {
    @Environment(\.presentationMode) var presentationMode:
    Binding <PresentationMode>
    
    var BackButton: some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        HStack{
            Image(systemName: "arrowshape.backward.fill")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
            Text("Back")
                .foregroundColor(.white)
        }
    }
    }
    
    var movie: Movie
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ScrollView {
                Group{
                    VideoView(videoID: movie.youtubeID)
                        .frame(width: 400, height: 200, alignment: .center)
                    Spacer()
                    Text(movie.title)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    
                    VStack(alignment: .leading, spacing: 10) {
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
                            .frame(width: 300, height:40)
                            .background(Color.white)
                        }
                    
                        HStack(alignment: .center, spacing: 0) {
                            Button{
                                //downloadList.append(movie)
                            } label: {
                                HStack(alignment: .center, spacing: 20){
                                    Image(systemName: "square.and.arrow.down")
                                        .resizable()
                                        .frame(width: 20, height: 20, alignment: .center)
                                        .foregroundColor(.black)
                                    Text("Download")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.black)
                                }
                            }
                            .frame(width: 300, height:40)
                            .background(Color.gray)
                        }
                    }
 
                    Text(movie.welcomeDescription)
                        .foregroundColor(Color.white)
                        .frame(alignment:.topLeading)
                    Text("Cast")
                        .font(.title2)
                        .foregroundColor(Color.white)
                        .offset(x: 10)
                    ForEach(movie.castList.indices, id: \.self) { index in
                        Text("\(movie.castList[index].castName)")
                    }
                    
                    Divider()
                    HStack {
                        Text("Genre")
                            .foregroundColor(Color.white)
                            .offset(x: 10)
                        
                        //                        ForEach(movie.categories.indices, id: \.self) {
                        //
                        //                            Text(self.movie.categories)
                        //                                .foregroundColor(Color.white)
                        //                                .offset(x: 10)
                        //
                        //                        }
                    }
                    Divider()
                }
                .padding()
                
            }
            .navigationTitle(movie.title).foregroundColor(.white)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton)
        }
    }
}

struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetail(movie: movies[0])
    }
}
