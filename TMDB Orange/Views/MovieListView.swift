//
//  MovieListView.swift
//  TMDB Orange
//
//  Created by Administrator  on 17/06/22.
//

import SwiftUI

struct MovieListView: View {
    @ObservedObject private var nowPlayingState = MovieListViewModel()
    @ObservedObject private var upcomingState = MovieListViewModel()
    @ObservedObject private var topRatedState = MovieListViewModel()
    @ObservedObject private var popularState = MovieListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                if nowPlayingState.movies != nil {
                    MoviePosterCorouselView(title: "Now Playing", movies: nowPlayingState.movies!)
                        .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                        .listRowSeparator(.hidden)
                } else {
                    LoadingView(isLoading: nowPlayingState.isLoading, error: nowPlayingState.error) {
                        self.nowPlayingState.loadMovies(with: .nowPlaying)
                    }
                }
                
                if upcomingState.movies != nil {
                    MovieBackdropCarouselView(title: "Upcoming", movies: upcomingState.movies!)
                        .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                        .listRowSeparator(.hidden)
                } else {
                    LoadingView(isLoading: upcomingState.isLoading, error: upcomingState.error) {
                        self.upcomingState.loadMovies(with: .upcoming)
                    }
                }
                
                if topRatedState.movies != nil {
                    MovieBackdropCarouselView(title: "Top Rated", movies: topRatedState.movies!)
                        .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                        .listRowSeparator(.hidden)
                } else {
                    LoadingView(isLoading: topRatedState.isLoading, error: topRatedState.error) {
                        self.topRatedState.loadMovies(with: .topRated)
                    }
                }
                
                if popularState.movies != nil {
                    MovieBackdropCarouselView(title: "Popular", movies: popularState.movies!)
                        .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 16, trailing: 0))
                        .listRowSeparator(.hidden)
                } else {
                    LoadingView(isLoading: popularState.isLoading, error: popularState.error) {
                        self.popularState.loadMovies(with: .popular)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("TMDB ByOrange")
            .onAppear {
                self.nowPlayingState.loadMovies(with: .nowPlaying)
                self.upcomingState.loadMovies(with: .upcoming)
                self.topRatedState.loadMovies(with: .topRated)
                self.popularState.loadMovies(with: .popular)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
