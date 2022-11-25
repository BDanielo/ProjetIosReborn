//
//  EntryController.swift
//  JournalCoreDataSwiftUI
//

import Foundation
import CoreData
import Combine

class EntryController: ObservableObject {

   @Published var entries: [Entry] = []
   
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
       let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
       let moc = CoreDataStack.shared.mainContext

       do {
           entries = try moc.fetch(fetchRequest)
            
       } catch {
           NSLog("Erreur de lecture de données : \(error)")

       }
   }

   // Fonction de création d'un enregistrement
    
   func createEntry(title: String, entryDescription: String) {
       _ = Entry(title: title, entryDescription: entryDescription)
       saveToPersistentStore()
   }

    // Fonction de mise à jour d'un enregistrement

   func updateEntry(entry: Entry, title: String, entryDescription: String) {
       entry.title = title
       entry.entryDescription = entryDescription
    
       saveToPersistentStore()
   }

    // Fonctions de suppression d'un enregistrement

    func deleteEntry(entry: Entry) {
       let mainC = CoreDataStack.shared.mainContext
       mainC.delete(entry)
       saveToPersistentStore()    }
    
    func deleteEntry(at indexSet: IndexSet) {
        guard let index = Array(indexSet).first else { return }
        
        let entry = self.entries[index]
        
        deleteEntry(entry: entry)
        
    }
}

