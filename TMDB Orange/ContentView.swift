//
//  ContentView.swift
//  TMDB Orange
//
//  Created by Administrator  on 15/06/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var tabSelection: Tabs = .home
    
    var body: some View {
        TabView(selection: $tabSelection){
            MovieListView()
                .tabItem {
                    VStack {
                        Image(systemName: "play.tv")
                        Text("Home")
                    }
                }
                .tag(Tabs.home)
            
            
            AccountView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.fill")
                        Text("Account")
                    }
                }
                .tag(Tabs.account)
        }
    }
    
    enum Tabs{
        case home, account
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
