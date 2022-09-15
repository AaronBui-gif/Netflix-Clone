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
