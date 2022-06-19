//
//  ActivityIndicatorView.swift
//  TMDB Orange
//
//  Created by Administrator  on 17/06/22.
//

import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIActivityIndicatorView(style: .medium)
        view.startAnimating()
        return view
    }
}
