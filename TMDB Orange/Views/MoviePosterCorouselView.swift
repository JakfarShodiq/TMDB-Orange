//
//  MoviePosterCorouselView.swift
//  TMDB Orange
//
//  Created by Administrator  on 17/06/22.
//

import SwiftUI

struct MoviePosterCorouselView: View {
    
    let title: String
    let movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(self.movies, id: \.id) { movie in
                        NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                            MoviePosterCard(movie: movie)
                        }.buttonStyle(.plain)
                    }
                }
            }
        }
    }
}

struct MoviePosterCorouselView_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterCorouselView(title: "Now Playing", movies: MMovie.stubbedMovies)
    }
}
