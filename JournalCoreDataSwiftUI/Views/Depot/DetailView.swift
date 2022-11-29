//
//  DetailView.swift
//  JournalCoreDataSwiftUI
//

import SwiftUI

// Affichage d'un enregistrement en mode détaillé

struct DetailView: View {
    @ObservedObject var depotController: DepotController
    @State var depot: Depot
    @State var depotDescription = ""
    
    
    @State private var showing: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {

                Button(action: {
                    self.showing = true
                }) {
                    Text("Modifier")
                }.frame(width: 90).padding().background(Color.blue).clipShape(RoundedRectangle(cornerRadius: 10)).foregroundColor(.white).sheet(isPresented: $showing) {
                    EditView(depotController: self.depotController, depot: self.depot)
                }
                }
                .padding()
                .onAppear {
            
            }
                .navigationBarTitle(Text("Nom : "+(depot.nom ?? "Emplacement nom")), displayMode: .inline)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(depotController: DepotController(), depot: Depot(nom: "Test"))
    }
}
