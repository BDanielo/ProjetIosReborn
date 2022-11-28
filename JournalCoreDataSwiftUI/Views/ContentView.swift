//
//  ContentView.swift
//  JournalCoreDataSwiftUI
//

import SwiftUI

// Vue principale

struct ContentView: View {
    
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        
        VStack{
            Text("Reflexo")
                .padding(.bottom)
        }.frame(minWidth: 0, maxWidth: .infinity, alignment: .top).background(Color(UIColor.systemBlue))
        
        TabView {
            DepotView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Depots").foregroundColor(Color(UIColor.white))
                }.tag(0)
//            VueCategories()
//                .tabItem {
//                    Image(systemName: "square.split.2x2")
//                    Text("Categories")
//                }.tag(1)
//            VueArticles()
//                .tabItem {
//                    Image(systemName: "cube.box.fill")
//                    Text("Articles").foregroundColor(.yellow)
//                }.tag(2)
        }.onAppear {
            UITabBar.appearance().backgroundColor = UIColor.systemBlue
            UITabBar.appearance().isTranslucent = false
            UITabBar.appearance().unselectedItemTintColor = .white
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
