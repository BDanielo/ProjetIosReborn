//
//  RowView.swift
//  JournalCoreDataSwiftUI
//

import SwiftUI

// Affichage d'un enregistrement en mode liste

struct RowView: View {
    
    @ObservedObject var article: Articles
   
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(article.nom ?? "Emplacement titre").font(.title)
                Spacer()
                Text(String(article.qte)).font(.caption)
            }
            Spacer()
            Text(article.desc ?? "Emplacement description").font(.callout)
        }.padding()
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(article: Articles(desc: "Journal d'aperçu", nom: "Aperçu", qte: 0))
    }
}
