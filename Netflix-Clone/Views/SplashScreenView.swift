//
//  SplashScreenView.swift
//  Netflix-Clone
//
//  Created by Huy Bui Thanh on 29/08/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct SplashScreenView: View {
    
    // MARK: Properties
    @State var saveList: [SaveList] = []
    @State var animationFinished: Bool = false
    @State var animationStarted: Bool = false
    @State var removeGif = false
    
    // MARK: Body
    var body: some View {
        ZStack{

            MainPageView()
            ZStack {
                
               
                Color.black.ignoresSafeArea()

                if !removeGif {
                    ZStack{
                        if animationStarted {
                            if animationFinished {
                               Color.black.ignoresSafeArea()
                            } else {
                            AnimatedImage(url: getLogoURL())
                                .aspectRatio(contentMode: .fit)
                            }
                        } else {
                            // Showing first frame
                            Image("logoStarted")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                    }
                    .animation(.none, value: animationFinished)
                }
                
            }
            .opacity(animationFinished ? 0:1)
        }
        .onAppear{
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                
                animationStarted = true
                // This gif will take about 2.7s to finish
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.7) {
                    
                    // Animation has problems will trigger the gif again
                    withAnimation(.easeInOut(duration: 2)) {
                        animationFinished = true
                        
                    }
                    
                    // Gif Ends then switch view
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.7) {
                        removeGif = true
                    }
                }
            }

        }
    }
    
    // MARK: Function get logo.gif
    func getLogoURL() -> URL{
        let bundle = Bundle.main.path(forResource: "logo", ofType: "gif")
        let url = URL(fileURLWithPath: bundle ?? "")
        
        return url
    }
}

// MARK: Preview
struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
