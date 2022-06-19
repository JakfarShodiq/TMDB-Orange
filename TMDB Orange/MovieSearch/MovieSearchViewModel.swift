//
//  MovieSearchViewModel.swift
//  TMDB Orange
//
//  Created by Administrator  on 19/06/22.
//

import SwiftUI
import Combine

class MovieSearchViewModel: ObservableObject {
    
    @Published var query = ""
    @Published var movie: [Movie]?
    @Published var isLoading = false
    @Published var error: NSError?
    
    private var subscriptionToken: AnyCancellable?
    
    let movieService: MovieService
    init(movieService: MovieService = MovieStore.shared) {
        self.movieService = movieService
    }
    
    func startObserve() {
        guard subscriptionToken == nil else { return }
        
        self.subscriptionToken = self.$query
            .map { [weak self] text in
                self?.movie = nil
                self?.error = nil
                return text
            }.throttle(for: 1, scheduler: DispatchQueue.main, latest: true)
            .sink { [weak self] in self?.search(query: $0) }
    }
    
    func search(query: String) {
        self.movie = nil
        self.isLoading = false
        self.error = nil
        
        guard !query.isEmpty else {
            return
        }
        
        self.isLoading = true
        self.movieService.searchMovie(query: query) { [weak self] (result) in
            guard let self = self, self.query == query else { return }
            
            self.isLoading = false
            switch result {
            case .success(let response):
                self.movie = response.results
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
    deinit {
        self.subscriptionToken?.cancel()
        self.subscriptionToken = nil
    }
}
