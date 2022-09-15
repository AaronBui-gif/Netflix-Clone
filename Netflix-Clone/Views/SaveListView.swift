//
//  SaveListView.swift
//  Netflix-Clone
//
//  Created by Huy Bui Thanh on 13/09/2022.
//

import SwiftUI

struct SaveListView: View {
    
    // MARK: PROPERTIES
    @ObservedObject var vm : MainMessagesViewModel
    
    var saveList: [SaveList] = []
    init(){
        let local = MainMessagesViewModel()
        self.vm = local
        let savingList:[SaveList] = loads(inputJsonURL: "https://backend-ios.herokuapp.com/saveList/userName/\(vm.chatUser?.email ?? "")")
        self.saveList = savingList
    }
    // MARK: BODY
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack(spacing: 15) {
                    
                    // MARK: Navigation Bar
                    NavigationBar()
                        .offset(y:13)
                    
                    // MARK: MAIN CONTENT
                    ScrollView {
                        //VStack{
                        ZStack(alignment: .leading) {
                            LazyVGrid(columns: [
                                GridItem(.flexible(minimum: 100, maximum: 200)),
                                GridItem(.flexible(minimum: 100, maximum: 200)),
                                GridItem(.flexible(minimum: 100, maximum: 200))
                            ], spacing: 12, content: {
                                
                                // MARK: Display save list movie
                                ForEach(vm.savedLists, id:\.self) { movie in
                                    //MOVIES
                                    NavigationLink{
                                        MovieDetailView(movie: movie.movie)
                                    } label: {
                                        
                                        MovieRow(movie: movie.movie)
                                    }
                                    
                                }
                            })
                        }
                        
                        .navigationBarTitle("Movies")
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarBackButtonHidden(true)
                        
                    } // Scroll View
                    .frame(minHeight:600, maxHeight: 7000)
                    
//                    // MARK: Navigation Bar Low
//                    NavigationBarLow()
//                        .offset(y:17)
                    Image (systemName: "arrow.down.circle")
                    
                }
                
                .frame(maxHeight: .infinity, alignment: .top)
                
            }.navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear{
            vm.fetch()
        }
    }
}

// MARK: Preview
struct SaveListView_Previews: PreviewProvider {
    static var previews: some View {
        SaveListView()
    }
}
