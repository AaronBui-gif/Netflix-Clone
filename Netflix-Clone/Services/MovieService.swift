//
//  MovieService.swift
//  Netflix-Clone
//
//  Created by Hue Pham on 06/09/2022.
//

import Foundation

protocol MovieService{
    func fetchMovies(from endpoint: MovieListEndpoint, completion: @escaping(Result<MovieResponse, MovieError>)->())
    func fetchMovie(movieName: String, completion: @escaping(Result<Movie, MovieError>)->())
}

enum MovieListEndpoint: String, CaseIterable{
    case loading = "movie"
    
    var description: String{
        switch self{
        case .loading:
            return "Loading"
        }
    }
}

enum MovieError: Error, CustomNSError{
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    
    var localizedDescription: String{
        switch self {
        case .apiError:
            return "Failed to fetch data"
        case .invalidEndpoint:
            return "Invalid endpoint"
        case .invalidResponse:
            return "Invalid response"
        case .noData:
            return "No data"
        case .serializationError:
            return "Failed to decode data"
        }
    }
    
    var errorUserInfo: [String : Any]{
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}
