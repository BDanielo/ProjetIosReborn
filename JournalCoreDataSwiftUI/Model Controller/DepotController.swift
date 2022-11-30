//
//  DepotController.swift
//  JournalCoreDataSwiftUI
//

import Foundation
import CoreData
import Combine

class DepotController: ObservableObject {

   @Published var entries: [Depot] = []
    
    var articleController = ArticleController()
    
   
   init() {
       getEntries()
   }
    
   func saveToPersistentStore() {
       let moc = CoreDataStack.shared.mainContext
       do {
           try moc.save()
           getEntries()
        
       } catch {
           NSLog("Erreur de contexte managed object : \(error)")
       }
   }

    // Fonction de lecture des enregistrements

   func getEntries() {
       let fetchRequest: NSFetchRequest<Depot> = Depot.fetchRequest()
       let moc = CoreDataStack.shared.mainContext

       do {
           entries = try moc.fetch(fetchRequest)
            
       } catch {
           NSLog("Erreur de lecture de données : \(error)")

       }
   }
    
    // Fonction de lecture des enregistrements

    func getEntriesById(idDepot:UUID) {
       let fetchRequest: NSFetchRequest<Depot> = Depot.fetchRequest()
       let moc = CoreDataStack.shared.mainContext
        let idDepotString=idDepot.uuidString

       fetchRequest.predicate = NSPredicate(
           format: "idDepot LIKE %@", idDepotString
       )
       
       do {
           entries = try moc.fetch(fetchRequest)
            
       } catch {
           NSLog("Erreur de lecture de données : \(error)")

       }
   }

   // Fonction de création d'un enregistrement
    
   func createDepot(nom: String) {
       _ = Depot(nom: nom)
       saveToPersistentStore()
   }

    // Fonction de mise à jour d'un enregistrement

   func updateDepot(depot: Depot, nom: String) {
       depot.nom = nom
       saveToPersistentStore()
   }

    // Fonctions de suppression d'un enregistrement

    func deleteDepot(depot: Depot) {
       let mainC = CoreDataStack.shared.mainContext
       let stringIdDepot=(depot.idDepot?.uuidString)!
       articleController.deleteArticleFromDepot(idDepot:stringIdDepot)
       mainC.delete(depot)
       saveToPersistentStore()
        

    }
    
    func deleteDepot(at indexSet: IndexSet) {
        guard let index = Array(indexSet).first else { return }
        
        let depot = self.entries[index]
        
        deleteDepot(depot: depot)
    }
}

