//
//  Categorie+Convenience.swift
//  JournalCoreDataSwiftUI
//
//  Created by Daniel Armieux on 25/11/2022.
//  Copyright © 2022 Nelson Gonzalez. All rights reserved.
//

import Foundation
import CoreData

//modif entry

extension Categorie {

    @discardableResult convenience init(nom: String, idCategorie: UUID = UUID(), desc: String, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {

       self.init(context: context)

       self.idCategorie = idCategorie
       self.nom = nom
        self.desc = desc
   }
}

