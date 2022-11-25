//
//  Entry+Convenience.swift
//  JournalCoreDataSwiftUI
//

import Foundation
import CoreData

extension Entry {

   @discardableResult convenience init(title: String, timeStamp: Date = Date(), id: UUID = UUID(), entryDescription: String, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {

       self.init(context: context)

       self.id = id
       self.title = title
       self.timeStamp = timeStamp
       self.entryDescription = entryDescription
   }
}
