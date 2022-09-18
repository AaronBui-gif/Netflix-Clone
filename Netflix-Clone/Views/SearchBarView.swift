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

struct SearchBarView: View {
    
    // MARK: Properties
    @State var currentIndex: Int = 0
    @State var searchText = ""
    @State var isSearching = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    // MARK: BODY
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            VStack(spacing: 15) {
                
                // MARK: Main Content
                ScrollView {
                    VStack{
                        ZStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                // MARK: Search Bar
                                SearchBar(searchText: $searchText, isSearching: $isSearching)
                            }
                        }
                        
                        // MARK: LIST OF MOVIES
                        ZStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                
                                // MARK: Looping through array of movie
                                ForEach(movies.filter({ "\($0)".contains(searchText) || searchText.isEmpty }), id: \.self) { movie in
                                    NavigationLink{ MovieDetailView(movie: movie)} label: {
                                        // MARK: Display image and name of movie
                                        HStack {
                                            Image(movie.imageName)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 200)
                                                .cornerRadius(12)
                                            Text(movie.title)
                                                .foregroundColor(.white)
                                            Spacer()
                                        }.padding()
                                    }
                                    Divider()
                                        .background(Color(.systemGray4))
                                        .padding(.leading)
                                }
                            }
                        }
                    }
                }
                .frame(minHeight:600, maxHeight: 7050)
                .offset(y: 10)
                
                Image (systemName: "arrow.down.circle")
                
            }
            
            .frame(maxHeight: .infinity, alignment: .top)
            
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
    }
}

// MARK: Preview
struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
    }
}

// MARK: Search Bar Components
struct SearchBar: View {
    
    // MARK: Properties
    @Binding var searchText: String
    @Binding var isSearching: Bool
    
    // MARK: BODY
    var body: some View {
        
        // MARK: Default Search
        HStack {
            HStack {
                TextField("Search movies", text: $searchText)
                    .padding(.leading, 24)
            }
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(6)
            .padding(.horizontal)
            .onTapGesture(perform: {
                isSearching = true
            })
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    
                    if isSearching {
                        Button(action: { searchText = "" }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .padding(.vertical)
                        })
                        
                    }
                    
                }.padding(.horizontal, 32)
                    .foregroundColor(.gray)
            ).transition(.move(edge: .trailing))
                .animation(.spring(), value: searchText)
            
            // MARK: Searching condition true Display
            if isSearching {
                Button(action: {
                    isSearching = false
                    searchText = ""
                    
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    
                }, label: {
                    Text("Cancel")
                        .padding(.trailing)
                        .padding(.leading, 0)
                        .foregroundColor(.white)
                })
                .transition(.move(edge: .trailing))
                .animation(.spring(), value: searchText)
            }
            
        }
    }
}
