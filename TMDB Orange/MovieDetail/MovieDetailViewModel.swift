//
//  MovieDetailViewModel.swift
//  TMDB Orange
//
//  Created by Administrator  on 18/06/22.
//

import SwiftUI

class MovieDetailViewModel: ObservableObject {
    
    @Published var movie: Movie?
    @Published var isLoading = false
    @Published var error: NSError?
    
    private let movieService: MovieService
    
    init(movieService: MovieService = MovieStore.shared) {
        self.movieService = movieService
    }
    
    func loadMovie(id: Int) {
        self.movie = nil
        self.isLoading = false
        self.movieService.fetchMovieInfo(id: id) { [weak self] (result) in
            guard let self = self else { return }
            
            self.isLoading = false
            switch result {
            case .success(let movie):
                self.movie = movie
                
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
}
