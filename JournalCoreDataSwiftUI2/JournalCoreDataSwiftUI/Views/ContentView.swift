//
//  ContentView.swift
//  JournalCoreDataSwiftUI
//

import SwiftUI

// Vue principale

struct ContentView: View {

    @ObservedObject var articleController = ArticleController()
    @State private var showing: Bool = false
        
    var body: some View {
        NavigationView {
            List {
            ForEach(articleController.articles, id: \.id) { article in
                NavigationLink(destination: DetailView(articleController: self.articleController, article: article)) {
                RowView(article: article)
                }
            }.onDelete(perform: self.articleController.deleteArticle)
                
            }
            .navigationBarTitle("Articles")
            .navigationBarItems(trailing: Button(action: {
                self.showing = true
            }, label: {
                Image(systemName: "plus.circle").font(.title).foregroundColor(.blue)
            }).sheet(isPresented: $showing, content: {
                AddArticleView(articleController: self.articleController)
            }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
