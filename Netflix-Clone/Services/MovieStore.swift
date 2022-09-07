//
//  MovieStore.swift
//  Netflix-Clone
//
//  Created by Huy Bui Thanh on 07/09/2022.
//

import Foundation

class MovieStore: MovieService{
    
    static let shared = MovieStore()
    private init() {}
    
    private let baseAPIURL = "https://backend-ios.herokuapp.com"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    func fetchMovies(from endpoint: MovieListEndpoint, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/movie/") else{
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
    }
    
    func fetchMovie(movieName: String, completion: @escaping (Result<Movie, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(movieName)") else{
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
    }
    private func loadURLAndDecode<D: Decodable>(url: URL, params:[String: String]? = nil, completion: @escaping (Result<D,MovieError>) -> ()){
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else{
            completion(.failure(.invalidEndpoint))
            return
        }
        guard let finalURL = urlComponents.url else{
            completion(.failure(.invalidEndpoint))
            return
        }
        urlSession.dataTask(with: finalURL){ [weak self](data, response, error) in
            guard let self = self else{return}
            if error != nil{
                self.executeCompletionHandlerMainThread(with: .failure(.apiError), completion: completion)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else{
                self.executeCompletionHandlerMainThread(with: .failure(.invalidResponse), completion: completion)
                return
            }
            guard let data = data else {
                self.executeCompletionHandlerMainThread(with: .failure(.noData), completion: completion)
                return
            }
            do{
                let decodeResponse = try self.jsonDecoder.decode(D.self, from: data)
                self.executeCompletionHandlerMainThread(with: .success(decodeResponse), completion: completion)
            } catch{
                self.executeCompletionHandlerMainThread(with: .failure(.serializationError), completion: completion)
            }
        }.resume()
    }
    
    private func executeCompletionHandlerMainThread<D: Decodable>(with result: Result<D, MovieError>, completion: @escaping (Result<D,MovieError>) -> ()){
        DispatchQueue.main.async{
            completion(result)
        }
    }
    
}
