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
