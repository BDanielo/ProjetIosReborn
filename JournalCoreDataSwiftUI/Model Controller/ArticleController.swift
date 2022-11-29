//
//  ArticleController.swift
//  JournalCoreDataSwiftUI
//
//  Created by Daniel Armieux on 25/11/2022.
//  Copyright © 2022 Nelson Gonzalez. All rights reserved.
//

import Foundation
import CoreData
import Combine

class ArticleController: ObservableObject {
    

   @Published var entries: [Article] = []
   
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
       let fetchRequest: NSFetchRequest<Article> = Article.fetchRequest()
       let moc = CoreDataStack.shared.mainContext

       do {
           entries = try moc.fetch(fetchRequest)
            
       } catch {
           NSLog("Erreur de lecture de données : \(error)")

       }
   }

   // Fonction de création d'un enregistrement
    
    
    func createArticle(nom: String, desc:String, qte:Int16, idDepot:UUID, idCategorie:UUID) {
        _ = Article(nom: nom, desc:desc, qte:qte, idDepot:idDepot, idCategorie:idCategorie)
       saveToPersistentStore()
   }

    // Fonction de mise à jour d'un enregistrement

    func updateArticle(article: Article, nom: String, desc: String, qte:Int16) {
       article.nom = nom
       article.desc = desc
        article.qte = qte
       saveToPersistentStore()
   }

    // Fonctions de suppression d'un enregistrement

    func deleteArticle(article: Article) {
       let mainC = CoreDataStack.shared.mainContext
       mainC.delete(article)
       saveToPersistentStore()    }
    
    func deleteArticle(at indexSet: IndexSet) {
        guard let index = Array(indexSet).first else { return }
        
        let article = self.entries[index]
        
        deleteArticle(article: article)
        
    }
}

