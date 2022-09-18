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

struct MovieDetailSummaryView: View {
    
    // MARK: Properties
    var movie: Movie
    @State var shouldShowTrailer = false
    @ObservedObject var vm = MainMessagesViewModel()
    // MARK: Body
    var body: some View {
        ZStack{
            Color.gray.ignoresSafeArea()
            VStack{
                HStack(spacing: 5){
                    Image(movie.imageName)
                        .resizable()
                        .frame(width: 150, height: 250)
                        .cornerRadius(20)
                    VStack {
                        
                        Text(movie.title)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.system(size: 25))
                        HStack {
                            Text(movie.publishedDate)
                            Text("\(movie.rating)")
                        }
                        Text(movie.welcomeDescription)
                            .foregroundColor(.white)
                    }
                }
                HStack(spacing: 30){
                    // Play Button
                    Button{
                        
                    } label: {
                        ZStack{
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: 180, height: 50)
                                .cornerRadius(10)
                            HStack(spacing: 20){
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
                    }
                    
                    // Download Button
                    Button{
                        vm.putData(movieID: movie.movieID, title: movie.title)
                    } label: {
                        VStack {
                            Image(systemName: "arrow.down.to.line")
                                .foregroundColor(.white)
                                .font(.system(size: 25))
                            Text("Download")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                        }
                        
                    }
                    
                    // Trailer Button
                    Button{
                        shouldShowTrailer.toggle()
                        showTrailer()
                    } label: {
                        VStack {
                            Image(systemName: "play")
                                .foregroundColor(.white)
                                .font(.system(size: 25))
                            Text("Trailer")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                        }
                    }
                    
                }
                // Trailer Button
                Button{
                    shouldShowTrailer.toggle()
                    showTrailer()
                } label: {
                    HStack{
                        Image(systemName: "info.circle")
                            .foregroundColor(.white)
                            .font(.system(size: 25))
                        Text("Episodes & Information")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                        Spacer()
                            .frame(width: 90)
                        Image(systemName: "arrow.right")
                            .foregroundColor(.white)
                            .font(.system(size: 25))
                    }
                }
            }
        }
    }
    
    // MARK: Function show trailer
    private func showTrailer(){
        if shouldShowTrailer {
            if let window = UIApplication.shared.windows.first {
                print("Change to Video View")
                window.rootViewController = UIHostingController(rootView: MovieDetailView(movie: movie))
                window.makeKeyAndVisible()
            }
        }
    }
}

struct MovieDetailSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailSummaryView(movie: movies[0])
    }
}
