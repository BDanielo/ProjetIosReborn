//
//  ContentView.swift
//  JournalCoreDataSwiftUI
//

import SwiftUI

// Vue principale

struct DepotView: View {

    @ObservedObject var depotController = DepotController()
    @State private var showing: Bool = false
    @State var NomDep = "🏢 Depots"
        
    var body: some View {
        NavigationView {
            List {
            ForEach(depotController.entries, id: \.id) { depot in

                RowView(depot: depot)
            }.onDelete(perform: self.depotController.deleteDepot)
                
            }
            .navigationBarTitle(NomDep)
            
            .navigationBarItems(trailing: Button(action: {
                self.showing = true
            }, label: {
                Image(systemName: "plus.circle").font(.title).foregroundColor(.blue)
            }).sheet(isPresented: $showing, content: {
                AddDepotView(depotController: self.depotController)
            }))
            
            
            
        }
    }
}

struct DepotView_Previews: PreviewProvider {
    static var previews: some View {
        DepotView()
    }
}
