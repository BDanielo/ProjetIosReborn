//
//  CategorieView.swift
//  JournalCoreDataSwiftUI
//
//  Created by Daniel Armieux on 25/11/2022.
//  Copyright © 2022 Nelson Gonzalez. All rights reserved.
//

import SwiftUI

// Vue principale

struct CategorieView: View {

    @ObservedObject var categorieController = CategorieController()
    @State private var showing: Bool = false
    
    @State private var filtre: String = ""

    @State private var afficherFiltreNom: Bool =  false
    @State private var filtreNom:String=""
    
    var filteredCategorie: [Categorie] {
        switch filtre {
        case "nom":
            afficherFiltreNom=true
            return categorieController.entries.filter { ($0.nom?.lowercased() ?? "").contains(filtreNom.lowercased()) }
        default:
            afficherFiltreNom=false
            return categorieController.entries
        }
    }
        
    var body: some View {
        NavigationView {
            List {
                if(afficherFiltreNom) {
                    HStack{
                    Text("Nom : ")
                    TextField("Nom", text:$filtreNom).autocapitalization(.none)
                    }
                }
            ForEach(filteredCategorie, id: \.id) { categorie in
                NavigationLink(destination: CategorieDetailView(categorieController: self.categorieController, categorie: categorie)) {
                CategorieRowView(categorie: categorie)
                }
            }.onDelete(perform: self.categorieController.deleteCategorie)
                
            }
            .navigationBarTitle("Categories")
            .navigationBarItems(trailing: Button(action: {
                self.showing = true
            }, label: {
                Image(systemName: "plus.circle").font(.title).foregroundColor(.blue)
            }).sheet(isPresented: $showing, content: {
                AddCategorieView(categorieController: self.categorieController)
            }))
            
            .navigationBarItems(leading: Button(action: {
            },label : {
                Picker("▼ Filtrer", selection:$filtre) {
                    Text("▼ Aucun filtres").tag("aucun filtre").foregroundColor(.black)
                    Text("▼ nom").tag("nom").foregroundColor(.black)
                }.onChange(of: filtre) {
                    filtre in majFiltre()
                }
            }))
        }
    }
    
    func majFiltre() -> Void {
        categorieController.getEntries()
        switch filtre {
        case "nom":
            afficherFiltreNom=true
        default:
            afficherFiltreNom=false
        }
    }
}

struct CategorieView_Previews: PreviewProvider {
    static var previews: some View {
        CategorieView()
    }
}
