//
//  DetailView.swift
//  JournalCoreDataSwiftUI
//

import SwiftUI

// Affichage d'un enregistrement en mode détaillé

struct DetailView: View {
    @ObservedObject var articleController: ArticleController
    @State var article: Articles
    @State var desc = ""
    @State var qte: Int16 = 0
    
    @State private var showing: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text(article.desc ?? "Emplacement description").font(.callout).padding()
                Spacer()
                Text(String(article.qte)).font(.caption)
                Spacer()
                Button(action: {
                    self.showing = true
                }) {
                    Text("Modifier")
                }.frame(width: 90).padding().background(Color.green).clipShape(RoundedRectangle(cornerRadius: 10)).foregroundColor(.white).sheet(isPresented: $showing) {
                    EditView(articleController: self.articleController, article: self.article, description: self.$desc, qte: self.qte)
                }
                }
                .padding()
                .onAppear {
                self.desc = self.article.desc ?? ""
                    self.qte = Int16(self.article.qte)
            }
            .navigationBarTitle(Text(article.nom ?? "Emplacement titre"), displayMode: .inline)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(articleController: ArticleController(), article: Articles(desc: "Testing description", nom: "Test", qte: 0))
    }
}
