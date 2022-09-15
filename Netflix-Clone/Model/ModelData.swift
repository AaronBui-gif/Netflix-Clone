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

import Foundation
import SwiftUI

// MARK: Load JSON API to array
var movies: [Movie] = load(inputJsonURL: "https://backend-ios.herokuapp.com/movie?fbclid=IwAR2OetUECYxuzW7gBPspT9H8XWaoNa4kwhToxcb4g6Er3S31nTNcH8JJJ0s")
var popularMovies: [Movie] = load(inputJsonURL: "https://backend-ios.herokuapp.com/movie/popularMovies")
var romanceMovies: [Movie] = load(inputJsonURL: "https://backend-ios.herokuapp.com/movie/genre/Romance")
var horrorMovies: [Movie] = load(inputJsonURL: "https://backend-ios.herokuapp.com/movie/genre/Horror")
var actionMovies: [Movie] = load(inputJsonURL: "https://backend-ios.herokuapp.com/movie/genre/Action")
var thrillerMovies: [Movie] = load(inputJsonURL: "https://backend-ios.herokuapp.com/movie/genre/Thriller")
var comedyMovies: [Movie] = load(inputJsonURL: "https://backend-ios.herokuapp.com/movie/genre/Comedy")
var scificMovies: [Movie] = load(inputJsonURL: "https://backend-ios.herokuapp.com/movie/genre/Sci-Fic")

// MARK: Function load API
func load(inputJsonURL: String) -> [Movie] {
    if let url = URL(string: inputJsonURL) {
        if let data = try? Data(contentsOf: url) {
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode([Movie].self, from: data)
                return decoded
            } catch let error {
                fatalError("Failed to decode JSON: \(error)")
            }
        }
    }
    return [] as [Movie]
}

// MARK: Function load API
func loads(inputJsonURL: String) -> [SaveList] {
    if let url = URL(string: inputJsonURL) {
        if let data = try? Data(contentsOf: url) {
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode([SaveList].self, from: data)
                return decoded
            } catch let error {
                fatalError("Failed to decode JSON: \(error)")
            }
        }
    }
    return [] as [SaveList]
}
