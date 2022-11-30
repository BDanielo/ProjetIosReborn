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
    @ObservedObject var categorieController = CategorieController()
    
    @State private var showing: Bool = false
    @State private var showing2: Bool = false
    
    @State public var filtrationDepot = false
    
    @State public var depotChoisi: Depot?
    
    @State private var filtre: String = ""
    @State private var afficherFiltreCategorie: Bool =  false
    @State private var filtreCategorieId: UUID?
    @State private var afficherFiltreNom: Bool =  false
    @State private var filtreNom:String=""
    
    @State private var testNUM:Int16=0
    
    @State private var selectedCategorie: Categorie?
    @State private var selectCategorieId: UUID?
    
    
    
    var filteredArticle: [Article] {
        switch filtre {
        case "categorie":
            afficherFiltreCategorie=true
            afficherFiltreNom=false
            return articleController.entries.filter { $0.idCategorie == selectedCategorie?.idCategorie }
        case "nom":
            afficherFiltreNom=true
            afficherFiltreCategorie=false
            return articleController.entries.filter { ($0.nom?.lowercased() ?? "").contains(filtreNom.lowercased()) }
        default:
            afficherFiltreNom=false
            afficherFiltreCategorie=false
            return articleController.entries
        }
    }
    
    var body: some View {
        NavigationView {
            VStack{
                VStack{
                    List {
                        if(afficherFiltreNom) {
                            HStack{
                            Text("Nom : ")
                            TextField("Nom", text:$filtreNom).autocapitalization(.none)
                            }
                        }
                        else if (afficherFiltreCategorie) {
                            Picker("Categorie", selection: $selectedCategorie) {
                                Text("auncune")
                                ForEach(categorieController.entries, id: \.id) { categorie in
                                    Text(categorie.nom ?? "").tag(Optional(categorie))
                                }
                            }
                        }
                        if(filtrationDepot==false) {
                            ForEach(filteredArticle, id: \.id) { article in
                                NavigationLink(destination: ArticleDetailView(articleController: self.articleController, article: article)) {
                                    ArticleRowView(article: article)
                                }.onAppear(){
                                    print("PATATE")
                                    majFiltre()
                                }
                            }.onDelete(perform: self.articleController.deleteArticle)
                        } else {
                            ForEach(filteredArticle, id: \.id) {
                                article in
                                if(article.idDepot==depotChoisi!.idDepot) {
                                    NavigationLink(destination: ArticleDetailView(articleController: self.articleController, article: article)) {
                                        ArticleRowView(article: article)
                                    }.onAppear(){
                                        print("PATATE")
                                        majFiltre()
                                        
                                    }}
                            }.onDelete(perform: self.articleController.deleteArticle)
                        }
                        
                    }
                    .navigationBarTitle(Text("📦 Articles"))
                    .navigationBarItems(trailing: Button(action: {
                        self.showing = true
                    }, label: {
                        Image(systemName: "plus.circle").font(.title).foregroundColor(.blue)
                    }).sheet(isPresented: $showing, content: {
                        if(filtrationDepot==false) {
                            AddArticleView(articleController: self.articleController, idDepot: UUID(), filtrationDepot:filtrationDepot, idDepotChoisi: UUID())
                        } else {
                            AddArticleView(articleController: self.articleController, idDepot: depotChoisi!.idDepot!, filtrationDepot:filtrationDepot, idDepotChoisi: depotChoisi!.idDepot!)
                        }
                    }))
                    .navigationBarItems(leading: Button(action: {
                    },label : {
                        Picker("▼ Filtrer", selection:$filtre) {
                            Text("▼ Aucun filtres").tag("aucun filtre").foregroundColor(.black)
                            Text("▼ categorie").tag("categorie").foregroundColor(.black)
                            Text("▼ nom").tag("nom").foregroundColor(.black)
                        }.onChange(of: filtre) {
                            filtre in majFiltre()
                        }
                    }))
                    .navigationBarItems(leading: Button(action: {
                        self.showing2 = true
                    }, label: {
                        if(filtrationDepot) {
                            Text((depotChoisi!.nom ?? "").prefix(10))
                            Image(systemName: "pencil.circle").font(.title).foregroundColor(.blue)}
                    }).sheet(isPresented: $showing2, onDismiss:{
                        //nomDepot=depotChoisi.nom!
                    }, content: {
                        EditView(depotController: depotController, depot: depotChoisi!)
                    }))
                    
                    
                    
                }
                
            }
        }
    }
    
    func majFiltre() -> Void {
        testNUM+=1
        articleController.getEntries()
        switch filtre {
        case "categorie":
            afficherFiltreCategorie=true
            afficherFiltreNom=false
        case "nom":
            afficherFiltreNom=true
            afficherFiltreCategorie=false
        default:
            afficherFiltreNom=false
            afficherFiltreCategorie=false
        }
    }
}

//struct ArticleView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArticleView(idDepotChoisi: UUID())
//    }
//}
