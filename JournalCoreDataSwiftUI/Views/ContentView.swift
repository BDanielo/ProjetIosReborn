//
//  ContentView.swift
//  JournalCoreDataSwiftUI
//

import SwiftUI

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

extension TabView {

//    func myTabViewStyle() -> some View {
//        self.background(Color(UIColor.systemGray6))
//
//    }
}

// Vue principale

struct ContentView: View {
    
//    init() {
//            UITabBar.appearance().isTranslucent = false
//        }
    
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var depotController = DepotController()
//    @ObservedObject var depot: Depot
//    @State var NOMdepot = ""
    
    var body: some View {
        
        VStack{
            Text("Stockovore")
                .padding(.bottom)
                .foregroundColor(.blue)
                .font(.largeTitle)
        }.frame(minWidth: 0, maxWidth: .infinity, alignment: .top)
        
        TabView {
            DepotView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Depots").foregroundColor(Color(UIColor.white))
                }.tag(0)
            CategorieView()
                .tabItem {
                    Image(systemName: "square.split.2x2")
                    Text("Categories").foregroundColor(Color(UIColor.white))
                }.tag(1)
            ArticleView(filtrationDepot: false)
                .tabItem {
                    Image(systemName: "cube.box.fill")
                    Text("Articles").foregroundColor(Color(UIColor.white))
                }.tag(2)
        }.onAppear {
            UITabBar.appearance().backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 128/255, alpha: 1.0)
            UITabBar.appearance()
            //UITabBar.appearance().isTranslucent = false
            UITabBar.appearance().unselectedItemTintColor = .white
            
            
            
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
