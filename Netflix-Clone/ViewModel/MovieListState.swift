//
//  MovieListState.swift
//  Netflix-Clone
//
//  Created by Hue Pham on 07/09/2022.
//

import Foundation

class MovieListState: ObservableObject{
    @Published var movies: [Movie]?
    @Published var isLoading = false
    @Published var error: NSError?
    
    private let movieService: MovieService
    
    init(movieService: MovieService = MovieStore.shared){
        self.movieService = movieService
    }
    
    func loadMovies(with endpoint: MovieListEndpoint){
        self.movies = nil
        self.isLoading = false
        self.movieService.fetchMovies(from: endpoint){ [weak self] (result) in
            guard let self = self else {return}
            self.isLoading = false
            
            switch result{
            case .success(let response):
                self.movies = response.results
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
}
