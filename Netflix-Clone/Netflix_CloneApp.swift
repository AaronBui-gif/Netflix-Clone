//
//  Netflix_CloneApp.swift
//  Netflix-Clone
//
//  Created by Huy Bui Thanh on 29/08/2022.
//

import SwiftUI

@main
struct Netflix_CloneApp: App {
    @State var saveList: [SaveList] = []
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
//HomeView(mainMessageViewModel: MainMessagesViewModel(), saveList: $saveList)
        }
    }
}
