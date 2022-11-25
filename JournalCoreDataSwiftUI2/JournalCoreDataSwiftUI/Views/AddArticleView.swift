//
//  AddEntryView.swift
//  JournalCoreDataSwiftUI
//

import SwiftUI

// Affichage d'un enregistrement en mode insertion

struct AddArticleView: View {
    
    @ObservedObject var articleController: ArticleController
    @State private var nom = ""
    @State private var desc = ""
    @State private var qte = ""
    @Environment(\.presentationMode) var presentationMode
    @State private var isShowingAlert = false
   
    var body: some View {
        NavigationView {
            Form {
        VStack {
            TextField("Nom", text: $nom).padding().background(Color(red: 239/255, green: 243/255, blue: 244/255))
            TextField("Description", text: $desc).padding().background(Color(red: 239/255, green: 243/255, blue: 244/255))
            TextField("Quantite", text: $qte).padding().background(Color(red: 239/255, green: 243/255, blue: 244/255))
            Button(action: {
                if !self.nom.isEmpty && !self.desc.isEmpty {
                    self.articleController.createArticle(nom: self.nom, desc: self.desc, qte: Int16(self.qte) ?? 0)
                    self.nom = ""
                    self.desc = ""
                    self.qte = ""
                                  
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
        .navigationBarTitle("Nouveau journal", displayMode: .inline)
        .alert(isPresented: $isShowingAlert) {
            Alert(title: Text("Attention"), message: Text("Merci de saisir un titre et une description pour votre nouveau journal."), dismissButton: .default(Text("Ok")))
        }
        }
    }
    }
}

struct AddArticleView_Previews: PreviewProvider {
    static var previews: some View {
        AddArticleView(articleController: ArticleController())
    }
}
