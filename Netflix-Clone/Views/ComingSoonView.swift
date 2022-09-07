//
//  ComingSoonView.swift
//  Netflix-Clone
//
//  Created by Huy Bui Thanh on 06/09/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct ComingSoonView: View {
    var body: some View {
        NavigationView{
            ZStack{
                Color.black.ignoresSafeArea()
                VStack(spacing: 15) {
                    ScrollView {
                        VStack(spacing: 0){
                            VStack{
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
