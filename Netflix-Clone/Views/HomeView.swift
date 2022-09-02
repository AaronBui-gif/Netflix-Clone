//
//  HomeView.swift
//  Netflix-Clone
//
//  Created by Hue Pham on 02/09/2022.
//

import SwiftUI
import Foundation

struct HomeView: View {
    var body: some View {
        //MARK - Navigation View
        NavigationView{
            ZStack{
                Color.black.ignoresSafeArea()
                
                // Main content begins
                VStack(spacing: 0){

                    ScrollView{
                        
                        // Header
                        ZStack {
                            NavigationLink{ MovieDetail(movie: movies[1])} label: {
                                    ZStack{
                                        Image("login-background2")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
                                        .ignoresSafeArea(.all)
                                        
                                        LinearGradient(
                                            gradient: Gradient(stops: [
                                                .init(color: .black, location: 0),
                                                .init(color: .black.opacity(0.1), location: 1)]),
                                                startPoint: .bottom,
                                                endPoint: .top
                                        )
                                    .ignoresSafeArea()
                                    }

                            }
                            VStack{
                                NavigationBar()
                                Spacer()
                            }
                            
                        }
                        
                        
                        // Top pi
                        
                    }
                    //Main content ends
                    
                    
                }//VStack
                
            }//ZStack
            
        }//NavigationView
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
