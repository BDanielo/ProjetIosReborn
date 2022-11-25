//
//  DetailView.swift
//  JournalCoreDataSwiftUI
//

import SwiftUI

// Affichage d'un enregistrement en mode détaillé

struct DetailView: View {
    @ObservedObject var entryController: EntryController
    @State var entry: Entry
    @State var entryDescription = ""
    
    var timeFormatter: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm"
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        let dateString = formatter.string(from: entry.timeStamp ?? Date())
        
        let returnString = "\(dateString)"
        return returnString
    }
    
    @State private var showing: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text(entry.entryDescription ?? "Emplacement description").font(.callout).padding()
                Spacer()
                Text(timeFormatter).font(.caption)
                Spacer()
                Button(action: {
                    self.showing = true
                }) {
                    Text("Modifier")
                }.frame(width: 90).padding().background(Color.green).clipShape(RoundedRectangle(cornerRadius: 10)).foregroundColor(.white).sheet(isPresented: $showing) {
                    EditView(entryController: self.entryController, entry: self.entry, description: self.$entryDescription)
                }
                }
                .padding()
                .onAppear {
                self.entryDescription = self.entry.entryDescription ?? ""
            }
            .navigationBarTitle(Text(entry.title ?? "Emplacement titre"), displayMode: .inline)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(entryController: EntryController(), entry: Entry(title: "Test", entryDescription: "Testing description"))
    }
}
