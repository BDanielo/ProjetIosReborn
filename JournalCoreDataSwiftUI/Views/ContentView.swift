//
//  ContentView.swift
//  JournalCoreDataSwiftUI
//

import SwiftUI

// Vue principale

struct ContentView: View {

    @ObservedObject var entryController = EntryController()
    @State private var showing: Bool = false
        
    var body: some View {
        NavigationView {
            List {
            ForEach(entryController.entries, id: \.id) { entry in
                NavigationLink(destination: DetailView(entryController: self.entryController, entry: entry)) {
                RowView(entry: entry)
                }
            }.onDelete(perform: self.entryController.deleteEntry)
                
            }
            .navigationBarTitle("Journaux")
            .navigationBarItems(trailing: Button(action: {
                self.showing = true
            }, label: {
                Image(systemName: "plus.circle").font(.title).foregroundColor(.blue)
            }).sheet(isPresented: $showing, content: {
                AddEntryView(entryController: self.entryController)
            }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
