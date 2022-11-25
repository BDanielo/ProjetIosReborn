//
//  CoreDataStack.swift
//  JournalCoreDataSwiftUI
//

import Foundation
import CoreData


class CoreDataStack {

       // Mise à disposition de CoreDataStack depuis n'importe quel point de l'App
    
       static let shared = CoreDataStack()

       // Mise à disposition d'un conteneur persistant

       lazy var container: NSPersistentContainer = {

           let container = NSPersistentContainer(name: "JournalCoreDataSwiftUI") // Nom du data model file

           container.loadPersistentStores { (_, error) in
               if let error = error {
                   fatalError("Failed to load persistent stores: \(error)")
               }
           }
           return container
       }()


       // Mise à disposition d'un accès au ManagedObjectContext (moc)

        var mainContext: NSManagedObjectContext {
           return container.viewContext
       }
}

