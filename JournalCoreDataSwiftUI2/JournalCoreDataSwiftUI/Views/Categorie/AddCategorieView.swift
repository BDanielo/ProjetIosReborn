//
//  AddCategorieView.swift
//  JournalCoreDataSwiftUI
//
//  Created by Daniel Armieux on 25/11/2022.
//  Copyright © 2022 Nelson Gonzalez. All rights reserved.
//

import SwiftUI

// Affichage d'un enregistrement en mode insertion

struct AddCategorieView: View {
    
    @ObservedObject var categorieController: CategorieController
    @State private var nom = ""
    @State private var desc = ""
    @Environment(\.presentationMode) var presentationMode
    @State private var isShowingAlert = false
   
    var body: some View {
        NavigationView {
            Form {
        VStack {
            TextField("Nom", text: $nom).padding().background(Color(red: 239/255, green: 243/255, blue: 244/255))
            TextField("Description", text: $desc).padding().background(Color(red: 239/255, green: 243/255, blue: 244/255))
            Button(action: {
                if !self.nom.isEmpty {
                    self.categorieController.createCategorie(nom: self.nom, desc: self.desc)
                    self.nom = ""
                    self.desc = ""
                                  
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.isShowingAlert = true
                }
                  
            }) {
                Text("Enregistrer")
                }.padding().background(Color.green).clipShape(RoundedRectangle(cornerRadius: 10)).foregroundColor(.white)
            Spacer()
        }
        .padding()
        .navigationBarTitle("Nouvelle categorie", displayMode: .inline)
        .alert(isPresented: $isShowingAlert) {
            Alert(title: Text("Attention"), message: Text("Merci de saisir un nom pour votre nouvelle categorie."), dismissButton: .default(Text("Ok")))
        }
        }
    }
    }
}

struct AddCategorieView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategorieView(categorieController: CategorieController())
    }
}
