//
//  MovieStore.swift
//  TMDB Orange
//
//  Created by Administrator  on 15/06/22.
//

import Foundation

final
class MovieStore: MovieService {
    
    static let shared = MovieStore()
    private init() {}
    
    private let apiKey = "038127b5dce67063d8729405f56c8b27"
    private let baseURL = "https://api.themoviedb.org/3/"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utility.jsonDecoder
    
    func fetchMovie(from endpoint: MovieListEndpoint, completion: @escaping (Result<MMovie, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseURL)/movie/\(endpoint.rawValue)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.apiRequest(url: url, completion: completion)
    }
    
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseURL)/movie/\(id)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.apiRequest(url: url, params: [
            "append_to_response" : "videos, credits"
        ], completion: completion)
    }
    
    private func apiRequest<D: Decodable>(url: URL, params: [String:String]? = nil, completion: @escaping (Result<D, MovieError>) -> ()) {
        guard var urlComponent = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value)} )
        }
        
        urlComponent.queryItems = queryItems
        
        guard let finalURL = urlComponent.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        urlSession.dataTask(with: finalURL) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if error != nil {
                self.executeInMainThread(with: .failure(.apiError), completion: completion)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.executeInMainThread(with: .failure(.invalidResponse), completion: completion)
                return
            }
            
            guard let data = data else {
                self.executeInMainThread(with: .failure(.noData), completion: completion)
                return
            }
            
            do {
                let decodedResponse = try self.jsonDecoder.decode (D.self, from: data)
                self.executeInMainThread(with: .success (decodedResponse), completion: completion)
            } catch {
                self.executeInMainThread(with: .failure(.serializationError), completion: completion)
            }
        }.resume()
    }
    
    private func executeInMainThread<D: Decodable>(with result: Result<D, MovieError>, completion: @escaping (Result<D, MovieError>) -> ()) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
