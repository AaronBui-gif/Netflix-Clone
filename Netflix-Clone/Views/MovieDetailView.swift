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

struct MovieDetailView: View {
    
    // MARK: Properties
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var tabIndex = 0
    var movie: Movie
    var tabItems = [
        "Episodes", "Trailers", "Others"
    ]
    
    @ObservedObject var vm = MainMessagesViewModel()
    @State var showMovieInfo = false
    
    // MARK: BODY
    var body: some View {
        
        ZStack  {
            Color.black.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 16){
                    VideoView(videoID: movie.youtubeID)
                        .frame(width: 370, height: 200, alignment: .center)
                     
                    // Save to List button SAVE TO LIST BUTTON
                    
                    HStack (alignment: .center, spacing: 28) {
                        VStack (spacing: 4){
                            
                            // MARK: - Submit button
                            Button {
                                vm.putData(movieID: movie.movieID, title: movie.title)
                            } label: {
                                VStack(spacing: 4){
                                Image(systemName: "plus")
                                    .font(.system(size: 20))
                                Text("Save to My List")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color.gray)
                                }
                            }
                           
                        }
                        
                        // MARK: Ranking button
                        VStack (spacing: 4){
                            Image(systemName: "hand.thumbsup")
                            Text("Ranking")
                                .font(.system(size: 14))
                                .foregroundColor(Color.gray)
                        }
                        
                        // MARK: Share button
                        VStack (spacing: 4){
                            Image(systemName: "arrowshape.turn.up.right")
                                .font(.system(size: 20))
                            Text("Share")
                                .font(.system(size: 14))
                                .foregroundColor(Color.gray)
                        }
                       
                    }
                    .padding(.top, 8)
                    
                    // MARK: Movie Title
                    Text(movie.title)
                        .font(.system(size: 24))
                    .fontWeight(.bold)
                    
                    //MARK: Movie Description
                    Text(movie.welcomeDescription)
                    VStack(alignment: .center) {
                    HStack(alignment: .center, spacing: 0) {
                        
                        // MARK: Play Button
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
                
                    // MARK: Add List Button
                    HStack(alignment: .center, spacing: 0) {
                        Spacer()
                       
                        Button{
                            vm.putData(movieID: movie.movieID, title: movie.title)
                            vm.fetch()
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
                            
                            // MARK: Displaying Cast
                            ForEach(movie.castList.indices, id: \.self) { index in
                                VStack{
                                    Image(movie.castList[index].castImage)
                                        .resizable()
                                        .aspectRatio(2/3,contentMode: .fit)
//                                        .frame(width: 120, height: 130, alignment: .center)
                                        .frame(height: 130, alignment: .center)
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

                    // MARK: Tab content
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
                            
                            // MARK: Display movies option
                            ForEach(movies) { movie in
                                NavigationLink{
                                    MovieDetailView(movie: movie)
                                } label: {
                                    HStack(alignment: .center){
                                        MovieRow(movie: movie)
                                }
                                }
                            }
                        })
                    }
                    
                }
            .padding(.horizontal, 16)
            }
            .navigationBarTitle(movie.title)
                .foregroundColor(.white)

            
        }
        
    }
}

// MARK: Preview
struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: movies[0])
    }
}
