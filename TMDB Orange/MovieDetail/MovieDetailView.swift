//
//  MovieDetailView.swift
//  TMDB Orange
//
//  Created by Administrator  on 18/06/22.
//

import SwiftUI

struct MovieDetailView: View {
    
    let movieId: Int
    @ObservedObject private var movieDetailState = MovieDetailViewModel()
    
    var body: some View {
        ZStack {
            LoadingView(isLoading: self.movieDetailState.isLoading, error: self.movieDetailState.error) {
                self.movieDetailState.loadMovie(id: self.movieId)
            }
            
            if self.movieDetailState.movie != nil {
                MovieDetailListView(movie: self.movieDetailState.movie!)
            }
        }
        .navigationBarTitle(self.movieDetailState.movie?.title ?? "")
        .navigationBarBackButtonHidden(false)
        .onAppear {
            self.movieDetailState.loadMovie(id: self.movieId)
        }
    }
}

struct MovieDetailListView: View {
    
    let movie: Movie
    
    var body: some View {
        List {
            MovieDetailImage(imageURL: self.movie.backdropURL)
                .listRowInsets(EdgeInsets())
            
            HStack {
                Text(movie.ratingText).foregroundColor(.yellow)
                Text(movie.scoreText)
                Spacer()
                Button(action: {
                    debugPrint("button pressed")
                    
                }) {
                    Image(systemName: "hand.thumbsup")
                }
                .frame(width: 50, height: 40, alignment: .center)
                
                Button(action: {
                    debugPrint("button pressed")
                    
                }) {
                    Image(systemName: "hand.thumbsdown")
                }
                .frame(width: 50, height: 40, alignment: .center)
            }
            
            Text("Overview")
                .fontWeight(.bold)
                .listRowSeparator(.hidden)
            Text(movie.overview)
                .listRowSeparator(.hidden)
            Text("Release date")
                .fontWeight(.bold)
                .listRowSeparator(.hidden)
            Text(movie.releaseDate ?? "")
                .listRowSeparator(.hidden)
            
        }
        .listStyle(.plain)
    }
}

struct MovieDetailImage: View {
    
    @ObservedObject private var imageLoader = ImageLoader()
    let imageURL: URL
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color.gray.opacity(0.3))
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
            }
        }
        .aspectRatio(16/9, contentMode: .fit)
        .onAppear {
            self.imageLoader.loadImage(with: self.imageURL)
        }
    }
    
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MovieDetailView(movieId: 338953)
        }
    }
}
