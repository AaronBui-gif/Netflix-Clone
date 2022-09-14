//
//  ModelData.swift
//  Rmit
//
//  Created by Huy Bui Thanh on 16/07/2022.
//

import Foundation
import SwiftUI

// MARK: Load JSON API to array
var movies: [Movie] = load(inputJsonURL: "https://backend-ios.herokuapp.com/movie?fbclid=IwAR2OetUECYxuzW7gBPspT9H8XWaoNa4kwhToxcb4g6Er3S31nTNcH8JJJ0s")
var popularMovies: [Movie] = load(inputJsonURL: "https://backend-ios.herokuapp.com/movie/popularMovies")
var romanceMovies: [Movie] = load(inputJsonURL: "https://backend-ios.herokuapp.com/movie/genre/Romance")
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
