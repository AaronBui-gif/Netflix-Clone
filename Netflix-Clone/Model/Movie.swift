//
//  Movie.swift
//  Rmit
//
//  Created by Huy Bui Thanh on 16/07/2022.
//

import Foundation

//struct Movie: Hashable, Codable, Identifiable {
//    let id: Int
//    let title: String
//    let year: Int
//    let cast:[String]
//    let genres:[String]
//    let summary: String
//
//    public var imageName: String
//    var image: Image {
//        Image(imageName)
//    }
//}
// MARK: - WelcomeElement
struct Movie: Codable {
    let movieID: Int
    let title, publishedDate, categories, youtubeID: String
    let imageName: String
    let rating: Double
    let welcomeDescription, creator: String
    let castList: [CastList]

    enum CodingKeys: String, CodingKey {
        case movieID = "movieId"
        case title, publishedDate, categories, youtubeID, imageName, rating
        case welcomeDescription = "description"
        case creator, castList
    }
}

// MARK: - CastList
struct CastList: Codable {
    let castID: Int
    let castName: String

    enum CodingKeys: String, CodingKey {
        case castID = "castId"
        case castName
    }
}

struct MovieResponse: Decodable{
    let results: [Movie]
}
