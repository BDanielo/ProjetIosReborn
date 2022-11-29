//
//  ArticleDetailView.swift
//  JournalCoreDataSwiftUI
//
//  Created by Daniel Armieux on 25/11/2022.
//  Copyright © 2022 Nelson Gonzalez. All rights reserved.
//


import SwiftUI

// Affichage d'un enregistrement en mode détaillé

struct ArticleDetailView: View {
    @ObservedObject var articleController: ArticleController
    @ObservedObject var depotController = DepotController()
    @ObservedObject var categorieController = CategorieController()
    @State var article: Article
    @State var articleDescription = ""
//    @State public var filtrationDepot : Bool
//    @State public var depotChoisi : Depot?
    
    
    @State private var showing: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Description : "+(article.desc ?? "Emplacement description")).font(.callout).padding()
                Text("Quantite : "+(String(article.qte) )).font(.callout).padding()
                ForEach(depotController.entries, id: \.id) { depot in
                    if (depot.id == article.idDepot) {
                        Text("Dépôt : "+depot.nom!).font(.callout).padding()
                    }
                }
                ForEach(categorieController.entries, id: \.id) { categorie in
                    if (categorie.idCategorie == article.idCategorie!) {
                        Text("Catégorie : "+categorie.nom!).font(.callout).padding()
                    }
                }
                Spacer()
                Button(action: {
                    self.showing = true
                }) {
                    Text("Modifier")
                }.frame(width: 90).padding().background(Color.blue).clipShape(RoundedRectangle(cornerRadius: 10)).foregroundColor(.white).sheet(isPresented: $showing) {
                    ArticleEditView(articleController: self.articleController, article: self.article, description: self.$articleDescription)
                }
                }
                .padding()
                .onAppear {
                self.articleDescription = self.article.desc ?? ""
            }
            .navigationBarTitle(Text("Nom : "+(article.nom ?? "Emplacement titre")), displayMode: .inline)
        }
    }
}

//struct ArticleDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArticleDetailView(articleController: ArticleController(), article: Article(nom: "Test", desc: "Testing description", qte: 16, idDepot: UUID()), filtrationDepot: false, idDepotChoisi: UUID())
//    }
//}
