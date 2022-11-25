//
//  EditView.swift
//  JournalCoreDataSwiftUI
//

import SwiftUI

// Affichage d'un enregistrement en mode édition

struct EditView: View {
    @ObservedObject var articleController: ArticleController
    @State var article: Articles
    @State private var nom = ""
    @Binding var description: String
    @State var qte: Int16
    @State private var isShowingAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
        
            VStack {
                TextField("\(article.nom ?? "Emplacement titre")", text: $nom).padding().background(Color(red: 239/255, green: 243/255, blue: 244/255))

                MultiLineTextField(txt: $description).frame(height: 200).padding(.bottom)
                
                TextField("\(article.qte)", value: $qte, formatter: NumberFormatter()).padding().background(Color(red: 239/255, green: 243/255, blue: 244/255))
                
                Button(action: {
                    if self.description.isEmpty {
                        self.description = " "
                    }
                    if !self.nom.isEmpty {
                        self.articleController.updateArticle(article: self.article, desc: self.description, nom: self.nom, qte: self.qte)
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        self.isShowingAlert = true
                    }
                }) {
                    Text("Enregistrer")
                }.frame(width: 90).padding().background(Color.green).clipShape(RoundedRectangle(cornerRadius: 10)).foregroundColor(.white)
                Spacer()
            }.onAppear {
                self.nom = self.article.nom!
                self.description = self.article.description
                self.qte = self.article.qte
            }
            .padding().navigationBarTitle("Modifier", displayMode: .inline)
            .alert(isPresented: $isShowingAlert) {
                Alert(title: Text("Attention"), message: Text("Merci de saisir un titre et une description pour votre nouveau journal."), dismissButton: .default(Text("Ok")))
            }
        }
    }
}

/*struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(articleController: ArticleController(), article: Articles(desc: "Description d'aperçu", nom: "Titre d'aperçu", qte: 0), description: "test", qte: 0)
    }
}*/
