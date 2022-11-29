//
//  AddDepotView.swift
//  JournalCoreDataSwiftUI
//

import SwiftUI

// Affichage d'un enregistrement en mode insertion

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}



struct AddDepotView: View {
    
    @ObservedObject var depotController: DepotController
    @State private var nom = ""
    @Environment(\.presentationMode) var presentationMode
    @State private var isShowingAlert = false
   
    var body: some View {
        NavigationView {
            Form {
        VStack {
            TextField("Nom", text: $nom).placeholder(when: nom.isEmpty) {
                Text("Nom").foregroundColor(.gray)
        }.padding().background(Color(red: 239/255, green: 243/255, blue: 244/255)).foregroundColor(.black)
            Button(action: {
                if !self.nom.isEmpty {
                self.depotController.createDepot(nom: self.nom)
                    self.nom = ""
                                  
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.isShowingAlert = true
                }
                  
            }) {
                Text("Ajouter le depot").buttonStyle(BorderlessButtonStyle())
                }.padding().background(Color.blue).clipShape(RoundedRectangle(cornerRadius: 10)).foregroundColor(.white).buttonStyle(BorderlessButtonStyle())
            Spacer()
        }
        .padding()
        .navigationBarTitle("Nouveau depot", displayMode: .inline)
        .alert(isPresented: $isShowingAlert) {
            Alert(title: Text("Attention"), message: Text("Merci de saisir un nom pour votre nouveau depot."), dismissButton: .default(Text("Ok")))
        }
        }
    }
    }
}

struct AddDepotView_Previews: PreviewProvider {
    static var previews: some View {
        AddDepotView(depotController: DepotController())
    }
}
