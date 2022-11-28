//
//  CategorieView.swift
//  JournalCoreDataSwiftUI
//
//  Created by Daniel Armieux on 25/11/2022.
//  Copyright © 2022 Nelson Gonzalez. All rights reserved.
//

import SwiftUI

// Vue principale

struct CategorieView: View {

    @ObservedObject var categorieController = CategorieController()
    @State private var showing: Bool = false
        
    var body: some View {
        NavigationView {
            List {
            ForEach(categorieController.entries, id: \.id) { categorie in
                NavigationLink(destination: CategorieDetailView(categorieController: self.categorieController, categorie: categorie)) {
                CategorieRowView(categorie: categorie)
                }
            }.onDelete(perform: self.categorieController.deleteCategorie)
                
            }
            .navigationBarTitle("Categories")
            .navigationBarItems(trailing: Button(action: {
                self.showing = true
            }, label: {
                Image(systemName: "plus.circle").font(.title).foregroundColor(.blue)
            }).sheet(isPresented: $showing, content: {
                AddCategorieView(categorieController: self.categorieController)
            }))
        }
    }
}

struct CategorieView_Previews: PreviewProvider {
    static var previews: some View {
        CategorieView()
    }
}
