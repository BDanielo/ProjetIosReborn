//
//  AddArticleView.swift
//  JournalCoreDataSwiftUI
//
//  Created by Daniel Armieux on 25/11/2022.
//  Copyright © 2022 Nelson Gonzalez. All rights reserved.
//

import SwiftUI

// Affichage d'un enregistrement en mode insertion

struct AddArticleView: View {
    
    @ObservedObject var articleController: ArticleController
    @ObservedObject var categorieController = CategorieController()
    @State private var nom = ""
    @State private var desc = ""
    @State private var qte = ""
    @State private var categorie = ""
    @State public var idDepot: UUID
    @Environment(\.presentationMode) var presentationMode
    @State private var isShowingAlert = false
    @State public var filtrationDepot : Bool
    @State public var idDepotChoisi : UUID
    
    @State private var selectedCategorie: Categorie?
    @State private var selectCategorieId: UUID?
   
    var body: some View {
        NavigationView {
            Form {
        VStack {
            TextField("Nom", text: $nom).padding().background(Color(red: 239/255, green: 243/255, blue: 244/255))
            TextField("Description", text: $desc).padding().background(Color(red: 239/255, green: 243/255, blue: 244/255))
            TextField("Quantite", text: $qte).padding().background(Color(red: 239/255, green: 243/255, blue: 244/255))
            Picker("Categorie", selection: $selectedCategorie) {
                ForEach(categorieController.entries, id: \.id) { categorie in
                    Text(categorie.nom!).tag(Optional(categorie))
                    
                    }
                }.id(UUID().uuidString)

            Spacer()

            Spacer()

            
            Spacer()
            Button(action: {
                if !self.nom.isEmpty && !(self.selectedCategorie?.nom ?? "").isEmpty {
                    self.articleController.createArticle(nom: self.nom, desc: self.desc, qte:Int16(self.qte) ?? 0, idDepot: self.idDepot, idCategorie: self.selectedCategorie!.idCategorie!)
                    self.nom = ""
                    self.desc = ""
                    self.qte = "0"

                                  
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.isShowingAlert = true
                }
                  print("Article créé")
            }) {
                Text("Enregistrer").padding().background(Color.green).clipShape(RoundedRectangle(cornerRadius: 10)).foregroundColor(.white).buttonStyle(BorderlessButtonStyle())
            }.buttonStyle(BorderlessButtonStyle())
            Spacer()
        }
        .padding()
        .navigationBarTitle("Nouvel article", displayMode: .inline)
        .alert(isPresented: $isShowingAlert) {
            Alert(title: Text("Attention"), message: Text("Merci de saisir un nom pour votre nouvelle article."), dismissButton: .default(Text("Ok")))
        }
        }
    }
    }
}

//struct AddArticleView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddArticleView(articleController: ArticleController(), idDepot: UUID(), filtrationDepot: false, idDepotChoisi: UUID())
//    }
//}
