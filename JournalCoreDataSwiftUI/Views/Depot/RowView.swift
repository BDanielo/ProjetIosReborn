//
//  RowView.swift
//  JournalCoreDataSwiftUI
//

import SwiftUI

// Affichage d'un enregistrement en mode liste

struct RowView: View {
    @ObservedObject var depotController = DepotController()
    @ObservedObject var depot: Depot
    @State var NOMdepot = ""
   
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(depot.nom ?? "Emplacement nom").font(.title)
                NavigationLink(destination: ArticleView( filtrationDepot: true, depotChoisi: depot)) {
                Text("")
                }.onAppear {
                    NOMdepot = ""
                    NOMdepot += (depot.nom ?? "")
                }
            }
        }.padding()
    }
}



struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(depot: Depot(nom: "Aperçu"))
    }
}
