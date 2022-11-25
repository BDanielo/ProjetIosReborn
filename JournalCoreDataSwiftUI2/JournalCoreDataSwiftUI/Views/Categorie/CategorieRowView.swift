//
//  CategorieRowView.swift
//  JournalCoreDataSwiftUI
//
//  Created by Daniel Armieux on 25/11/2022.
//  Copyright © 2022 Nelson Gonzalez. All rights reserved.
//


import SwiftUI

// Affichage d'un enregistrement en mode liste

struct CategorieRowView: View {
    
    @ObservedObject var categorie: Categorie
   
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(categorie.nom ?? "Emplacement nom").font(.title)

            }
            Spacer()
            Text(categorie.desc ?? "Emplacement description").font(.callout)
        }.padding()
    }
}

struct CategorieRowView_Previews: PreviewProvider {
    static var previews: some View {
        CategorieRowView(categorie: Categorie(nom: "Aperçu", desc: "Categorie aperçu"))
    }
}

