//
//  ArticleView.swift
//  JournalCoreDataSwiftUI
//
//  Created by Daniel Armieux on 25/11/2022.
//  Copyright © 2022 Nelson Gonzalez. All rights reserved.
//

import SwiftUI

// Vue principale

struct ArticleView: View {

    @ObservedObject var articleController = ArticleController()
    @ObservedObject var depotController = DepotController()
    @State private var showing: Bool = false
    @State private var showing2: Bool = false
    @State public var filtrationDepot = false
    @State public var idDepotChoisi : UUID
    @State public var nomDepot : String
    @State public var depotChoisi: Depot

        
    var body: some View {
        NavigationView {
            List {
                if(filtrationDepot==false) {
            ForEach(articleController.entries, id: \.id) { article in
                NavigationLink(destination: ArticleDetailView(articleController: self.articleController, article: article, filtrationDepot:filtrationDepot, idDepotChoisi: UUID())) {
                ArticleRowView(article: article)
                }
            }.onDelete(perform: self.articleController.deleteArticle)
                } else {
                    ForEach(articleController.entries, id: \.id) {
                        article in
                        if(article.idDepot==idDepotChoisi) {
                            NavigationLink(destination: ArticleDetailView(articleController: self.articleController, article: article, filtrationDepot: filtrationDepot, idDepotChoisi: idDepotChoisi)) {
                        ArticleRowView(article: article)
                        }}
                    }.onDelete(perform: self.articleController.deleteArticle)
                }
                
            }
            .navigationBarTitle("Articles")
            .navigationBarItems(trailing: Button(action: {
                self.showing = true
            }, label: {
                Image(systemName: "plus.circle").font(.title).foregroundColor(.blue)
            }).sheet(isPresented: $showing, content: {
                if(filtrationDepot==false) {
                    AddArticleView(articleController: self.articleController, idDepot: UUID(), filtrationDepot:filtrationDepot, idDepotChoisi: idDepotChoisi)
                } else {
                    AddArticleView(articleController: self.articleController, idDepot: idDepotChoisi, filtrationDepot:filtrationDepot, idDepotChoisi: idDepotChoisi)
                }
            }))
            .navigationBarItems(leading: Button(action: {
                self.showing2 = true
            }, label: {
                Text("Depot : "+nomDepot).font(.system(size: 36))
                Image(systemName: "pencil.circle").font(.title).foregroundColor(.blue)
            }).sheet(isPresented: $showing2, onDismiss:{
                nomDepot=depotChoisi.nom!
            }, content: {
                EditView(depotController: depotController, depot: depotChoisi)
            })).onAppear() {
                nomDepot=depotChoisi.nom!
            }
        }
    }
}

//struct ArticleView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArticleView(idDepotChoisi: UUID())
//    }
//}
