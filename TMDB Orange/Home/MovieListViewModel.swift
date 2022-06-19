//
//  MovieListViewModel.swift
//  TMDB Orange
//
//  Created by Administrator  on 17/06/22.
//

import SwiftUI

class MovieListViewModel: ObservableObject {
    
    @Published var movies: [Movie]?
    @Published var isLoading = false
    @Published var error: NSError?
    
    private let movieServices: MovieService
    
    init(movieServices: MovieService = MovieStore.shared) {
        self.movieServices = movieServices
    }
    
    func loadMovies(with endPoints: MovieListEndpoint) {
        self.movies = nil
        self.isLoading = true
        self.movieServices.fetchMovie(from: endPoints) { [weak self] (result) in
            guard let self = self else {
                return
            }
            self.isLoading = false
            
            switch result {
            case .success(let response):
                self.movies = response.results
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
    func loadTv(with endPoints: TvListEndpoint) {
        self.movies = nil
        self.isLoading = true
        self.movieServices.fetchTv(from: endPoints) { [weak self] (result) in
            guard let self = self else {
                return
            }
            self.isLoading = false
            
            switch result {
            case .success(let response):
                self.movies = response.results
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
}
