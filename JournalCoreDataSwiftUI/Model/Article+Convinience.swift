//
//  Article+Convinience.swift
//  JournalCoreDataSwiftUI
//
//  Created by Daniel Armieux on 25/11/2022.
//  Copyright © 2022 Nelson Gonzalez. All rights reserved.
//


import Foundation
import CoreData

//modif entry

extension Article {

    @discardableResult convenience init(nom: String, id: UUID = UUID(), desc: String, qte: Int16, idDepot:UUID, idCategorie:UUID, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {

       self.init(context: context)

       self.id = id
       self.nom = nom
       self.qte = qte
        self.desc = desc
        self.idDepot = idDepot
        self.idCategorie=idCategorie
   }
}

