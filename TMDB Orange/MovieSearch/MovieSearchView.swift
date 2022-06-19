//
//  MovieSearchView.swift
//  TMDB Orange
//
//  Created by Administrator  on 19/06/22.
//

import SwiftUI

struct MovieSearchView: View {
    
    @ObservedObject var movieSearchViewModel = MovieSearchViewModel()
    
    var body: some View {
        List {
            SearchBarView(placeholder: "Search Movie ...", text: self.$movieSearchViewModel.query)
                .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                .listRowSeparator(.hidden)
            
            LoadingView(isLoading: self.movieSearchViewModel.isLoading, error: self.movieSearchViewModel.error) {
                self.movieSearchViewModel.search(query: self.movieSearchViewModel.query)
            }
            
            if self.movieSearchViewModel.movie != nil {
                ForEach(self.movieSearchViewModel.movie!, id:\.id) { movie in
                    NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                        VStack(alignment: .leading) {
                            Text(movie.title)
                            Text(movie.releaseDate ?? "-")
                        }
                    }
                }
            }
        }
        .listStyle(.plain)
        .onAppear {
            self.movieSearchViewModel.startObserve()
        }
        .navigationTitle("Search")
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
