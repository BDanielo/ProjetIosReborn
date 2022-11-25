//
//  RowView.swift
//  JournalCoreDataSwiftUI
//

import SwiftUI

// Affichage d'un enregistrement en mode liste

struct RowView: View {
    
    @ObservedObject var entry: Entry
   
    var timeFormatter: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm"
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        let dateString = formatter.string(from: entry.timeStamp ?? Date())
        let returnString = "\(dateString)"
        return returnString
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(entry.title ?? "Emplacement titre").font(.title)
                Spacer()
                Text(timeFormatter).font(.caption)
            }
            Spacer()
            Text(entry.entryDescription ?? "Emplacement description").font(.callout)
        }.padding()
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(entry: Entry(title: "Aperçu", entryDescription: "Journal d'aperçu"))
    }
}
