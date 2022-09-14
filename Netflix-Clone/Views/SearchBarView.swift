//
//  SearchBarView.swift
//  Netflix-Clone
//
//  Created by Huy Bui Thanh on 08/09/2022.
//

import SwiftUI

struct SearchBarView: View {
    
    // MARK: Properties
    @State var currentIndex: Int = 0
    @State var searchText = ""
    @State var isSearching = false
    
    // MARK: BODY
    var body: some View {
        NavigationView{
            ZStack{
                Color.black.ignoresSafeArea()
                VStack(spacing: 15) {
                    
                    // MARK: Navigation Bar
                    NavigationBar()
                        .offset(y:13)
                    
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
                    
                    // MARK: NAVIGATIONBARLOW
                    NavigationBarLow()
                        .offset(y:17)
                    Image (systemName: "arrow.down.circle")
                    
                }
                
                .frame(maxHeight: .infinity, alignment: .top)
                
            }.navigationBarTitle("")
                .navigationBarHidden(false)
                .navigationBarTitleDisplayMode(.inline)
        }
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
