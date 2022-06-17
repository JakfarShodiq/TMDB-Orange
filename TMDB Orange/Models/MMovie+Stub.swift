//
//  MMovie+Stub.swift
//  TMDB Orange
//
//  Created by Administrator  on 17/06/22.
//

import Foundation

extension MMovie {
    static var stubbedMovies: [Movie] {
        let response: MMovie? = try? Bundle.main.loadAndDecodeJSON(filename: "movie_list")
        return response!.results
    }
    
    static var stubbedMovie: Movie {
        stubbedMovies[0]
    }
}

extension Bundle {
    func loadAndDecodeJSON<D: Decodable> (filename: String) throws -> D? {
        guard let url = self.url (forResource: filename, withExtension: "json") else {
            return nil
        }
        let data = try Data(contentsOf: url)
        let jsonDecoder = Utility.jsonDecoder
        let decodedModel = try jsonDecoder.decode(D.self, from: data)
        return decodedModel
    }
}
