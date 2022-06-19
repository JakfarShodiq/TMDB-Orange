//
//  MovieServices.swift
//  TMDB Orange
//
//  Created by Administrator  on 15/06/22.
//

import Foundation

protocol MovieService {
    func fetchMovie(from endpoint: MovieListEndpoint, completion: @escaping (Result<MMovie, MovieError>) -> ())
    func fetchMovieInfo(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ())
    func searchMovie(query: String, completion: @escaping (Result<MMovie, MovieError>) -> ())
    func fetchTv(from endpoint: TvListEndpoint, completion: @escaping (Result<MTvShows, MovieError>) -> ())
    func fetchReviews(id: Int, completion: @escaping (Result<MReview, MovieError>) -> ())
}

enum MovieListEndpoint: String, CaseIterable {
    case nowPlaying = "now_playing"
    case upcoming
    case topRated = "top_rated"
    case popular
    
    var description: String {
        switch self {
        case .nowPlaying: return "Now Playing"
        case .upcoming: return "Up Coming"
        case .topRated: return "Top Rated"
        case .popular: return "Popular"
        }
    }
}

enum TvListEndpoint: String, CaseIterable {
    case popular
    case airingToday = "airing_today"
    case onTheAir = "on_the_air"
    case topRated = "top_rated"
    
    var description: String {
        switch self {
        case .popular: return "Popular"
        case .airingToday: return "Airing Today"
        case .onTheAir: return "On TV"
        case .topRated: return "Top Rated"
        }
    }
}

enum MovieError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data"
        case .invalidEndpoint: return "Invalid Endpoint"
        case .invalidResponse: return "Invalid Endpoint"
        case .noData: return "No Data"
        case .serializationError: return "Failed to decode data"
        }
    }
    var errorUserInfo: [String:Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}
