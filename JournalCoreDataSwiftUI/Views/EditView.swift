//
//  EditView.swift
//  JournalCoreDataSwiftUI
//

import SwiftUI

// Affichage d'un enregistrement en mode édition

struct EditView: View {
    @ObservedObject var entryController: EntryController
    @State var entry: Entry
    @State private var title = ""
    @Binding var description: String
    @State private var isShowingAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
          
            VStack {
                TextField("\(entry.title ?? "Emplacement titre")", text: $title).padding().background(Color(red: 239/255, green: 243/255, blue: 244/255))

                MultiLineTextField(txt: $description).frame(height: 200).padding(.bottom)
                
                Button(action: {
                    if !self.title.isEmpty && !self.description.isEmpty {
                        self.entryController.updateEntry(entry: self.entry, title: self.title, entryDescription: self.description)
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        self.isShowingAlert = true
                    }
                }) {
                    Text("Enregistrer")
                }.frame(width: 90).padding().background(Color.green).clipShape(RoundedRectangle(cornerRadius: 10)).foregroundColor(.white)
                Spacer()
            }.onAppear {
                self.title = self.entry.title!
                self.description = self.entry.entryDescription!
            }
            .padding().navigationBarTitle("Modifier", displayMode: .inline)
            .alert(isPresented: $isShowingAlert) {
                Alert(title: Text("Attention"), message: Text("Merci de saisir un titre et une description pour votre nouveau journal."), dismissButton: .default(Text("Ok")))
            }
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(entryController: EntryController(), entry: Entry(title: "Titre d'aperçu", entryDescription: "Description d'aperçu"), description: .constant(""))
    }
}
