//
//  MoviePosterCard.swift
//  TMDB Orange
//
//  Created by Administrator  on 17/06/22.
//

import SwiftUI

struct MoviePosterCard: View {
    
    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()
    
    var body: some View {
        ZStack(alignment: .leading) {
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 4)
                Text(movie.title)
                    .multilineTextAlignment(.trailing)
                    .font(.headline)
                    .background(.black)
                    .foregroundColor(.white)
                    .offset(x: 8, y: 100)
            } else {
                Rectangle()
                    .fill(.gray.opacity(0.3))
                    .shadow(radius: 4)
                
                Text(movie.title)
                    .multilineTextAlignment(.trailing)
                    .font(.headline)
                    .background(.black)
                    .foregroundColor(.white)
                    .offset(x: 8, y: 100)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: 240)
        .onAppear {
            self.imageLoader.loadImage(with: self.movie.backdropURL)
        }
    }
}

struct MoviePosterCard_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterCard(movie: MMovie.stubbedMovie)
    }
}
