//
//  MTvShows.swift
//  TMDB Orange
//
//  Created by Administrator  on 19/06/22.
//

import Foundation

struct MTvShows: Decodable {
    let results: [TV]
}

struct TV: Decodable {
    let id: Int
    let name: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    let firstAirDate: String

    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w300\(backdropPath ?? "")")!
    }
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w300\(posterPath ?? "")")!
    }
}


