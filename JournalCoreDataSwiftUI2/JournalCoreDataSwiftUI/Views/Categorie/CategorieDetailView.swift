//
//  CategorieDetailView.swift
//  JournalCoreDataSwiftUI
//
//  Created by Daniel Armieux on 25/11/2022.
//  Copyright © 2022 Nelson Gonzalez. All rights reserved.
//


import SwiftUI

// Affichage d'un enregistrement en mode détaillé

struct CategorieDetailView: View {
    @ObservedObject var categorieController: CategorieController
    @State var categorie: Categorie
    @State var categorieDescription = ""
    
    
    @State private var showing: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text(categorie.desc ?? "Emplacement description").font(.callout).padding()
                Spacer()
                Button(action: {
                    self.showing = true
                }) {
                    Text("Modifier")
                }.frame(width: 90).padding().background(Color.green).clipShape(RoundedRectangle(cornerRadius: 10)).foregroundColor(.white).sheet(isPresented: $showing) {
                    CategorieEditView(categorieController: self.categorieController, categorie: self.categorie, description: self.$categorieDescription)
                }
                }
                .padding()
                .onAppear {
                self.categorieDescription = self.categorie.desc ?? ""
            }
            .navigationBarTitle(Text(categorie.nom ?? "Emplacement titre"), displayMode: .inline)
        }
    }
}

struct CategorieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CategorieDetailView(categorieController: CategorieController(), categorie: Categorie(nom: "Test", desc: "Testing description"))
    }
}
