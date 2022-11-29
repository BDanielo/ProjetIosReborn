//
//  CategorieEditView.swift
//  JournalCoreDataSwiftUI
//
//  Created by Daniel Armieux on 25/11/2022.
//  Copyright © 2022 Nelson Gonzalez. All rights reserved.
//

import SwiftUI

// Affichage d'un enregistrement en mode édition

struct CategorieEditView: View {
    @ObservedObject var categorieController: CategorieController
    @State var categorie: Categorie
    @State private var nom = ""
    @Binding var description: String
    @State private var isShowingAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
          
            VStack {
                TextField("\(categorie.nom ?? "Emplacement nom")", text: $nom).padding().background(Color(red: 239/255, green: 243/255, blue: 244/255)).foregroundColor(.black)

                MultiLineTextField(txt: $description).frame(height: 200).padding(.bottom).foregroundColor(.black)
                
                Button(action: {
                    if !self.nom.isEmpty && !self.description.isEmpty {
                        self.categorieController.updateCategorie(categorie: self.categorie, nom: self.nom, desc: self.description)
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        self.isShowingAlert = true
                    }
                }) {
                    Text("Enregistrer")
                }.frame(width: 90).padding().background(Color.blue).clipShape(RoundedRectangle(cornerRadius: 10)).foregroundColor(.white)
                Spacer()
            }.onAppear {
                self.nom = self.categorie.nom!
                self.description = self.categorie.desc!
            }
            .padding().navigationBarTitle("Modifier", displayMode: .inline)
            .alert(isPresented: $isShowingAlert) {
                Alert(title: Text("Attention"), message: Text("Merci de saisir un nom et une description pour votre nouvelle categorie."), dismissButton: .default(Text("Ok")))
            }
        }
    }
}

struct CategorieEditView_Previews: PreviewProvider {
    static var previews: some View {
        CategorieEditView(categorieController: CategorieController(), categorie: Categorie(nom: "Nom d'aperçu", desc: "Description d'aperçu"), description: .constant(""))
    }
}

