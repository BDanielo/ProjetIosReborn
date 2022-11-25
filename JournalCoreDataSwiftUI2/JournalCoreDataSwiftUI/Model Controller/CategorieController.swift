//
//  CategorieController.swift
//  JournalCoreDataSwiftUI
//
//  Created by Daniel Armieux on 25/11/2022.
//  Copyright © 2022 Nelson Gonzalez. All rights reserved.
//

import Foundation
import CoreData
import Combine

class CategorieController: ObservableObject {

   @Published var entries: [Categorie] = []
   
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
       let fetchRequest: NSFetchRequest<Categorie> = Categorie.fetchRequest()
       let moc = CoreDataStack.shared.mainContext

       do {
           entries = try moc.fetch(fetchRequest)
            
       } catch {
           NSLog("Erreur de lecture de données : \(error)")

       }
   }

   // Fonction de création d'un enregistrement
    
    func createCategorie(nom: String, desc:String) {
        _ = Categorie(nom: nom, desc:desc)
       saveToPersistentStore()
   }

    // Fonction de mise à jour d'un enregistrement

    func updateCategorie(categorie: Categorie, nom: String, desc: String) {
       categorie.nom = nom
       categorie.desc = desc
       saveToPersistentStore()
   }

    // Fonctions de suppression d'un enregistrement

    func deleteCategorie(categorie: Categorie) {
       let mainC = CoreDataStack.shared.mainContext
       mainC.delete(categorie)
       saveToPersistentStore()    }
    
    func deleteCategorie(at indexSet: IndexSet) {
        guard let index = Array(indexSet).first else { return }
        
        let categorie = self.entries[index]
        
        deleteCategorie(categorie: categorie)
        
    }
}

