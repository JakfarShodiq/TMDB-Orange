//
//  Movie.swift
//  TMDB Orange
//
//  Created by Administrator  on 15/06/22.
//

import Foundation

struct MMovie: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let id: Int
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    let runTime: Int?
    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w300\(backdropPath ?? "")")!
    }
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w300\(posterPath ?? "")")!
    }
}
