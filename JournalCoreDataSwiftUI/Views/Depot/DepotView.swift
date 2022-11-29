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
    
    @State private var filtre: String = ""

    @State private var afficherFiltreNom: Bool =  false
    @State private var filtreNom:String=""
    
    var filteredDepot: [Depot] {
        switch filtre {
        case "nom":
            afficherFiltreNom=true
            return depotController.entries.filter { ($0.nom?.lowercased() ?? "").contains(filtreNom.lowercased()) }
        default:
            afficherFiltreNom=false
            return depotController.entries
        }
    }
    
        
    var body: some View {
        NavigationView {
            List {
                if(afficherFiltreNom) {
                    HStack{
                    Text("Nom : ")
                    TextField("Nom", text:$filtreNom).autocapitalization(.none)
                    }
                }
            ForEach(filteredDepot, id: \.id) { depot in

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
            
            .navigationBarItems(leading: Button(action: {
            },label : {
                Picker("▼ Filtrer", selection:$filtre) {
                    Text("▼ Aucun filtres").tag("aucun filtre").foregroundColor(.black)
                    Text("▼ nom").tag("nom").foregroundColor(.black)
                }.onChange(of: filtre) {
                    filtre in majFiltre()
                }
            }))
            
            
            
        }
    }
    
    func majFiltre() -> Void {
        depotController.getEntries()
        switch filtre {
        case "nom":
            afficherFiltreNom=true
        default:
            afficherFiltreNom=false
        }
    }
}

struct DepotView_Previews: PreviewProvider {
    static var previews: some View {
        DepotView()
    }
}
