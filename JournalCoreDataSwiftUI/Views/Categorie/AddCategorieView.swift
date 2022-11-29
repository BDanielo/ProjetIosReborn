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
            VStack{
            TextField("Nom", text: $nom).placeholder(when: nom.isEmpty) {
                Text("Nom").foregroundColor(.gray)
        }.padding().background(Color(red: 239/255, green: 243/255, blue: 244/255)).foregroundColor(.black)
            TextField("Description", text: $desc).placeholder(when: desc.isEmpty) {
                Text("Description").foregroundColor(.gray)
        }.padding().background(Color(red: 239/255, green: 243/255, blue: 244/255)).foregroundColor(.black)
            }
            Button("Enregistrer",action: {
                if !self.nom.isEmpty {
                    self.categorieController.createCategorie(nom: self.nom, desc: self.desc)
                    self.nom = ""
                    self.desc = ""
                                  
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.isShowingAlert = true
                }
                  
            }).buttonStyle(BorderlessButtonStyle()).padding().background(Color.blue).clipShape(RoundedRectangle(cornerRadius: 10)).foregroundColor(.white)
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
