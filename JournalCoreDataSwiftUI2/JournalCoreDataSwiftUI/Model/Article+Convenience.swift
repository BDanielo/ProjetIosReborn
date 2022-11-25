//
//  Entry+Convenience.swift
//  JournalCoreDataSwiftUI
//

import Foundation
import CoreData

extension Articles {

   @discardableResult convenience init(desc: String, id: UUID = UUID(), idCategorie: UUID = UUID(), nom: String, qte: Int16, idDepot: UUID = UUID(), context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {

       self.init(context: context)

       self.id = id
       self.nom = nom
       self.desc = desc
       self.qte = qte
       self.idDepot = idDepot
       self.idCategorie = idCategorie
   }
}
