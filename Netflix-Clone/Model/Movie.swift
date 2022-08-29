//
//  Movie.swift
//  Rmit
//
//  Created by Huy Bui Thanh on 16/07/2022.
//

import Foundation
import SwiftUI

struct Movie: Hashable, Codable, Identifiable {
    let id: Int
    let title: String
    let year: Int
    let cast:[String]
    let genres:[String]
    let summary: String
    
    public var imageName: String
    var image: Image {
        Image(imageName)
    }
}
