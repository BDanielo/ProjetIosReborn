//
//  Entry+Convenience.swift
//  JournalCoreDataSwiftUI
//

import Foundation
import CoreData

//modif entry

extension Depot {

   @discardableResult convenience init(nom: String, id: UUID = UUID(), context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {

       self.init(context: context)

       self.id = id
       self.nom = nom
   }
}
