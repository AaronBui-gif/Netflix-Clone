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
import SDWebImageSwiftUI

struct ComingSoonView: View {
    
    // MARK: BODY
    var body: some View {
        NavigationView{
            ZStack{
                Color.black.ignoresSafeArea()
                VStack(spacing: 15) {
                    ScrollView {
                        VStack(spacing: 0){
                            VStack{
                                
                                // MARK: Navigation Bar
                                NavigationBar()
                                    .padding(.top, 42)
                                Spacer()
                                HStack {
                                    Image(systemName: "bell")
                                        .font(.system(size: 28))
                                        .foregroundColor(.white)
                                    Text("Notification")
                                        .foregroundColor(.white)
                                        .font(.system(size: 18))
                                        .fontWeight(.medium)
                                    Spacer()
                                        .frame(width: 230)
                                    Image(systemName: "arrow.right")
                                        .foregroundColor(.white)
                                }
                                .frame(height:50)
                                VideoView(videoID: "Go8nTmfrQd8")
                                    .frame(width: 400, height: 200, alignment: .center)
                                HStack{
                                    
                                }
                                VideoView(videoID: "Go8nTmfrQd8")
                                    .frame(width: 400, height: 200, alignment: .center)
                                VideoView(videoID: "Go8nTmfrQd8")
                                    .frame(width: 400, height: 200, alignment: .center)
                                VideoView(videoID: "Go8nTmfrQd8")
                                    .frame(width: 400, height: 200, alignment: .center)
                            }
                        }
                    }
                }
            }
            .ignoresSafeArea()
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ComingSoonView_Previews: PreviewProvider {
    static var previews: some View {
        ComingSoonView()
    }
}
