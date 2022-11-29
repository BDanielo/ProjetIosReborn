//
//  EditView.swift
//  JournalCoreDataSwiftUI
//

import SwiftUI

// Affichage d'un enregistrement en mode édition

struct EditView: View {
    @ObservedObject var depotController: DepotController
    @State var depot: Depot
    @State private var nom = ""
    @State private var isShowingAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
          
            VStack {
                TextField("\(depot.nom ?? "Emplacement nom")", text: $nom).padding().background(Color(red: 239/255, green: 243/255, blue: 244/255)).foregroundColor(.black)
                
                Button(action: {
                    if !self.nom.isEmpty {
                        self.depotController.updateDepot(depot: self.depot, nom: self.nom)
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        self.isShowingAlert = true
                    }
                }) {
                    Text("Enregistrer")
                }.frame(width: 90).padding().background(Color.blue).clipShape(RoundedRectangle(cornerRadius: 10)).foregroundColor(.white)
                Spacer()
            }.onAppear {
                self.nom = self.depot.nom!
            
            }
            .padding().navigationBarTitle("Modifier", displayMode: .inline)
            .alert(isPresented: $isShowingAlert) {
                Alert(title: Text("Attention"), message: Text("Merci de saisir un nom  pour votre nouveau depot."), dismissButton: .default(Text("Ok")))
            }
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(depotController: DepotController(), depot: Depot(nom: "Nom d'aperçu"))
    }
}
