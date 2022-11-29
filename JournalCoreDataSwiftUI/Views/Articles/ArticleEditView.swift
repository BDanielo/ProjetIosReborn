//
//  ArticleEditView.swift
//  JournalCoreDataSwiftUI
//
//  Created by Daniel Armieux on 25/11/2022.
//  Copyright © 2022 Nelson Gonzalez. All rights reserved.
//

import SwiftUI

// Affichage d'un enregistrement en mode édition

struct ArticleEditView: View {
    @ObservedObject var articleController: ArticleController
    @State var article: Article
    @State private var nom = ""
    @State private var qte = ""
    @Binding var description: String
    @State private var isShowingAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
          
            VStack {
                TextField("\(article.nom ?? "Emplacement nom")", text: $nom).padding().background(Color(red: 239/255, green: 243/255, blue: 244/255)).foregroundColor(.black)

                MultiLineTextField(txt: $description).frame(height: 200).padding(.bottom).foregroundColor(.black)
                
                TextField("\(article.nom ?? "Emplacement qte")", text: $qte).padding().background(Color(red: 239/255, green: 243/255, blue: 244/255)).foregroundColor(.black)
                
                Button(action: {
                    if !self.nom.isEmpty && !self.description.isEmpty {
                        self.articleController.updateArticle(article: self.article, nom: self.nom, desc: self.description, qte: Int16(self.qte)!)
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        self.isShowingAlert = true
                    }
                }) {
                    Text("Enregistrer")
                }.frame(width: 90).padding().background(Color.blue).clipShape(RoundedRectangle(cornerRadius: 10)).foregroundColor(.white)
                Spacer()
            }.onAppear {
                self.nom = self.article.nom!
                self.description = self.article.desc!
                self.qte = String(self.article.qte)
            }
            .padding().navigationBarTitle("Modifier", displayMode: .inline)
            .alert(isPresented: $isShowingAlert) {
                Alert(title: Text("Attention"), message: Text("Merci de saisir un nom et une description pour votre nouvelle article."), dismissButton: .default(Text("Ok")))
            }
        }
    }
}

//struct ArticleEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArticleEditView(articleController: ArticleController(), article: Article(nom: "Nom d'aperçu", desc: "Description d'aperçu", qte: 16, idDepot: UUID()), description: .constant(""))
//    }
//}
//
