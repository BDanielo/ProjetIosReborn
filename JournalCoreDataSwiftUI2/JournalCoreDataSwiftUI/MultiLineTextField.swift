//
//  MultiLineTextField.swift
//  JournalCoreDataSwiftUI
//

import SwiftUI

struct MultiLineTextField: UIViewRepresentable {
    
    @Binding var txt: String
    
    func makeCoordinator() -> MultiLineTextField.Coordinator {
        return MultiLineTextField.Coordinator(parent1: self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        // À la création de la vue
        let text = UITextView()
        text.isEditable = true
        text.isUserInteractionEnabled = true
        text.text = txt
        text.textColor = .gray
        text.backgroundColor = UIColor(red: 239/255, green: 243/255, blue: 244/255, alpha: 1)
        text.font = .systemFont(ofSize: 20)
        text.delegate = context.coordinator
        return text
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        // À la mise à jour de la vue
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        
        var parent: MultiLineTextField
        
        init(parent1: MultiLineTextField) {
            
            parent = parent1
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {

            textView.textColor = .black
        }

        func textViewDidChange(_ textView: UITextView) {

            self.parent.txt = textView.text
        }
    }
}
