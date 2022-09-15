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

struct NavigationBarLow: View {
    
    // MARK: BODY
    @State var saveList: [SaveList] = []
    var body: some View {
        VStack{
            HStack(alignment: .bottom, spacing: 73) {
                
                // MARK: Home Button
                NavigationLink{
                    HomeView(mainMessageViewModel: MainMessagesViewModel(), saveList: $saveList)
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                    .navigationBarTitleDisplayMode(.inline)} label: {
                        VStack {
                            Image (systemName: "house")
                                .font(.title2.bold())
                                .foregroundColor(Color.white)
                            Text("Menu")
                                .fontWeight(.semibold)
                                .font(.system(size: 13))
                                .foregroundColor(Color.white)
                        }
                    }
                
                // MARK: Comming Soon Button
                
                NavigationLink{
                    ComingSoonView()
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                        .navigationBarTitleDisplayMode(.inline)
                }
            label: {
                VStack {
                    Image (systemName: "play.rectangle.on.rectangle")
                        .font(.title2.bold())
                        .foregroundColor(Color.white)
                    Text("Coming Soon")
                        .fontWeight(.semibold)
                        .font(.system(size: 13))
                        .foregroundColor(Color.white)
                }
            }
                
                // MARK: Downloads button
                NavigationLink{}
            label: {
                VStack {
                    Image (systemName: "arrow.down.circle")
                        .font(.title2.bold())
                        .foregroundColor(Color.white)
                    Text("Downloads")
                        .fontWeight(.semibold)
                        .font(.system(size: 13))
                        .foregroundColor(Color.white)
                }
            }
                
            }
        }
    }
}

// MARK: Preview
struct NavigationBarLow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarLow().preferredColorScheme(.dark)
    }
}
