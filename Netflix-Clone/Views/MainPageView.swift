//
//  MainPageView.swift
//  group
//
//  Created by minh on 9/1/22.
//

import Foundation
import SwiftUI

struct MainPageView: View {
    
    // MARK: Properties
    let images = [
        CarouselSlider(image: "MainPage-background1"),
        CarouselSlider(image: "MainPage-background2"),
        CarouselSlider(image: "MainPage-background3"),
    ]
    
    // MARK: BODY
    var body: some View {
        NavigationView{
            ZStack(){
                // MARK: Background Color
                Color.black.ignoresSafeArea()
                
                //MARK: - CAROUSEL SLIDER
                
                // A tab in carousel
                TabView{
                    ForEach(images){image in
                        FeaturedItemView(image: image.image)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always)) // carousel dots indicator
                .offset(x: 0, y: -85)
                
                VStack(alignment: .center, spacing: nil){
                    //HEADER
                    HStack(alignment: .center, spacing: 10){
                        //MARK: - NETFLIX LOGO
                        Image("MainPage-logo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 124, height: 0, alignment: .center)
                            .ignoresSafeArea(.all)
                            .padding(.leading, -10)
                            .padding(.trailing, 100)
                            .offset(x: 0, y: 15)
                        
                        HStack(alignment: .center, spacing: 12){
                            //MARK: - PRIVACY BUTTON
                            Button{
                                print("PRIVACY")
                            } label: {
                                Text("Privacy")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18, weight: .semibold))
                                    .opacity(0.8)
                            }
                            .padding(.horizontal, 10)
                            //MARK: - LOGIN BUTTON
                            NavigationLink{
                                LoginView(mainMessageViewModel: MainMessagesViewModel(),didCompleteLoginProcess: {})
                            } label: {
                                Text("Log In")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18, weight: .semibold))
                                    .opacity(0.8)
                            }
                        }
                        .padding(.top, 35)
                    }
                    .frame(width: 390, height: 90, alignment: .center)
                    .background(LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: Color.black, location: 0),
                            .init(color: Color.black.opacity(0.55), location: 1)]),
                        startPoint: .top,
                        endPoint: .bottom))
                    
                    Spacer()
                    
                    // MARK: Footer
                    NavigationLink{
                        SignUpView(didCompleteLoginProcess: {}, mainMessageViewModel: MainMessagesViewModel())
                    } label: {
                        Text("Get Started")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                            .opacity(0.8)
                    }
                    .frame(width: 340, height: 45, alignment: .center)
                    .background(Color("red").opacity(0.9))
                    .cornerRadius(4)
                    .padding(.bottom, 56)
                    
                }
                .ignoresSafeArea()
                
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            
            
        }
    }
}

// MARK: Carousel Slider
struct CarouselSlider: Identifiable {
    let id = UUID()
    let image: String
}



// MARK: Preview
struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}
