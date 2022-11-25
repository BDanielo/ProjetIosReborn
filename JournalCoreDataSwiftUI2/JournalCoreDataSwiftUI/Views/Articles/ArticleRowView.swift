//
//  ArticleRowView.swift
//  JournalCoreDataSwiftUI
//
//  Created by Daniel Armieux on 25/11/2022.
//  Copyright © 2022 Nelson Gonzalez. All rights reserved.
//


import SwiftUI

// Affichage d'un enregistrement en mode liste

struct ArticleRowView: View {
    
    @ObservedObject var article: Article
   
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(article.nom ?? "Emplacement nom").font(.title)
                Spacer()
                Text("Quantite : "+String(article.qte)).font(.caption)
            }
            
            Spacer()
            Text(article.desc ?? "Emplacement description").font(.callout).foregroundColor(Color.gray)
        }.padding()
    }
}

struct ArticleRowView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleRowView(article: Article(nom: "Aperçu", desc: "Article aperçu", qte:16, idDepot: UUID()))
    }
}

