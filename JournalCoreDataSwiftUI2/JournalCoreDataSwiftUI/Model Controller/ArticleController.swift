//
//  EntryController.swift
//  JournalCoreDataSwiftUI
//

import Foundation
import CoreData
import Combine

class ArticleController: ObservableObject {

   @Published var articles: [Articles] = []
   
   init() {
       getArticles()
   }
    
   func saveToPersistentStore() {
       let moc = CoreDataStack.shared.mainContext
       do {
           try moc.save()
           getArticles()
        
       } catch {
           NSLog("Erreur de contexte managed object : \(error)")
       }
   }

    // Fonction de lecture des enregistrements

   func getArticles() {
       let fetchRequest: NSFetchRequest<Articles> = Articles.fetchRequest()
       let moc = CoreDataStack.shared.mainContext

       do {
           articles = try moc.fetch(fetchRequest)
            
       } catch {
           NSLog("Erreur de lecture de données : \(error)")

       }
   }

   // Fonction de création d'un enregistrement
    
    func createArticle(nom: String, desc: String, qte: Int16) {
       _ = Articles(desc: desc, nom: nom, qte: qte)
       saveToPersistentStore()
   }

    // Fonction de mise à jour d'un enregistrement

   func updateArticle(article: Articles, desc: String, nom: String, qte: Int16) {
       article.nom = nom
       article.desc = desc
       article.qte = qte
    
       saveToPersistentStore()
   }

    // Fonctions de suppression d'un enregistrement

    func deleteArticle(article: Articles) {
       let mainC = CoreDataStack.shared.mainContext
       mainC.delete(article)
       saveToPersistentStore()    }
    
    func deleteArticle(at indexSet: IndexSet) {
        guard let index = Array(indexSet).first else { return }
        
        let article = self.articles[index]
        
        deleteArticle(article: article)
        
    }
}

