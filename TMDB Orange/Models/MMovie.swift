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
    let releaseDate: String?
    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w300\(backdropPath ?? "")")!
    }
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w300\(posterPath ?? "")")!
    }
    
    var ratingText: String {
        let rating = Int(voteAverage)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "★"
        }
        return ratingText
    }
    
    var scoreText: String {
        guard ratingText.count > 0 else {
            return "n/a"
        }
        return "\(ratingText.count)/10"
    }
}

struct MReview: Decodable {
    let results: [Review]
}

struct Review: Decodable {
    let id: String
    let author: String
    let content: String
}
