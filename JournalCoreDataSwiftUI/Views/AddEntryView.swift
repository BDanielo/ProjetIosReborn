//
//  AddEntryView.swift
//  JournalCoreDataSwiftUI
//

import SwiftUI

// Affichage d'un enregistrement en mode insertion

struct AddEntryView: View {
    
    @ObservedObject var entryController: EntryController
    @State private var title = ""
    @State private var description = ""
    @Environment(\.presentationMode) var presentationMode
    @State private var isShowingAlert = false
   
    var body: some View {
        NavigationView {
            Form {
        VStack {
            TextField("Titre", text: $title).padding().background(Color(red: 239/255, green: 243/255, blue: 244/255))
            TextField("Description", text: $description).padding().background(Color(red: 239/255, green: 243/255, blue: 244/255))
            Button(action: {
                if !self.title.isEmpty && !self.description.isEmpty {
                self.entryController.createEntry(title: self.title, entryDescription: self.description)
                    self.title = ""
                    self.description = ""
                                  
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

struct AddEntryView_Previews: PreviewProvider {
    static var previews: some View {
        AddEntryView(entryController: EntryController())
    }
}
