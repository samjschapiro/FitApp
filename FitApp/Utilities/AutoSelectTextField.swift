//
//  AutoSelectTextField.swift
//  FitApp
//
//  Created by Matthew Finkel on 3/12/25.
//

import SwiftUI
import UIKit

struct AutoSelectTextField: UIViewRepresentable {
    @Binding var text: String
    var keyboardType: UIKeyboardType
    var backgroundColor: Color

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        textField.layer.cornerRadius = 5
        textField.keyboardType = keyboardType
        textField.delegate = context.coordinator
        textField.addTarget(context.coordinator, action: #selector(Coordinator.selectAllText), for: .editingDidBegin)
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        uiView.backgroundColor = UIColor(backgroundColor)
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: AutoSelectTextField

        init(_ parent: AutoSelectTextField) {
            self.parent = parent
        }

        @objc func selectAllText(textField: UITextField) {
            DispatchQueue.main.async {
                textField.selectAll(nil)
            }
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async {
                self.parent.text = textField.text ?? ""
            }
        }
    }
}







//struct AutoSelectTextField: UIViewRepresentable {
//    @Binding var text: String
//    var keyboardType: UIKeyboardType = .default
//    var backgroundColor: Color = Color.clear
//    var onEditingBegan: (() -> Void)? = nil
//    
//    func makeUIView(context: Context) -> UITextField {
//        let textField = UITextField()
//        textField.delegate = context.coordinator
//        textField.backgroundColor = UIColor(backgroundColor)
//        textField.inputView = UIView() // disables default keyboard
//        textField.textAlignment = .center
//        textField.keyboardType = keyboardType
//        textField.font = UIFont.systemFont(ofSize: 16)
//        
//        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.didTapTextField))
//        textField.addGestureRecognizer(tapGesture)
//
//        return textField
//    }
//
//    func updateUIView(_ uiView: UITextField, context: Context) {
//        uiView.text = text
//        uiView.backgroundColor = UIColor(backgroundColor)
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(text: $text, onEditingBegan: onEditingBegan)
//    }
//
//    class Coordinator: NSObject, UITextFieldDelegate {
//        var text: Binding<String>
//        var onEditingBegan: (() -> Void)?
//        
//        init(text: Binding<String>, onEditingBegan: (() -> Void)?) {
//            self.text = text
//            self.onEditingBegan = onEditingBegan
//        }
//        
//        @objc func didTapTextField(_ sender: UITapGestureRecognizer) {
//            sender.view?.becomeFirstResponder()
//            onEditingBegan?()
//        }
//    }
//}







//struct AutoSelectTextField: UIViewRepresentable {
//    @Binding var text: String
//    var keyboardType: UIKeyboardType = .default
//    var backgroundColor: Color = .clear
//    var onEditingBegan: (() -> Void)? = nil
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    func makeUIView(context: Context) -> UITextField {
//        let textField = UITextField()
//        textField.delegate = context.coordinator
//        textField.backgroundColor = UIColor(backgroundColor)
//        textField.keyboardType = keyboardType
//        textField.textAlignment = .center
//        textField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
//        textField.inputView = UIView() // disables system keyboard
//
//        let tap = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.didTapTextField))
//        textField.addGestureRecognizer(tap)
//
//        return textField
//    }
//
//    func updateUIView(_ uiView: UITextField, context: Context) {
//        uiView.text = text
//        uiView.backgroundColor = UIColor(backgroundColor)
//    }
//
//    // MARK: - Coordinator
//
//    class Coordinator: NSObject, UITextFieldDelegate {
//        var parent: AutoSelectTextField
//        static weak var currentFirstResponder: UITextField?
//
//        init(_ parent: AutoSelectTextField) {
//            self.parent = parent
//        }
//
//        @objc func didTapTextField(_ gesture: UITapGestureRecognizer) {
//            if let textField = gesture.view as? UITextField {
//                textField.becomeFirstResponder()
//                Coordinator.currentFirstResponder = textField
//                parent.onEditingBegan?()
//            }
//        }
//
//        func textFieldDidBeginEditing(_ textField: UITextField) {
//            Coordinator.currentFirstResponder = textField
//        }
//
//        func textFieldDidEndEditing(_ textField: UITextField) {
//            Coordinator.currentFirstResponder = nil
//        }
//
//        func textFieldDidChangeSelection(_ textField: UITextField) {
//            parent.text = textField.text ?? ""
//        }
//    }
//}






//struct AutoSelectTextField: UIViewRepresentable {
//    @Binding var text: String
//    var keyboardType: UIKeyboardType = .default
//    var backgroundColor: Color = .clear
//    var onEditingBegan: (() -> Void)? = nil
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    func makeUIView(context: Context) -> UITextField {
//        let textField = UITextField()
//        textField.delegate = context.coordinator
//        textField.backgroundColor = UIColor(backgroundColor)
//        textField.textAlignment = .center
//        textField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
//        textField.inputView = UIView() // disables system keyboard
//        textField.text = text // initial value
//
//        let tap = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.didTapTextField))
//        textField.addGestureRecognizer(tap)
//
//        return textField
//    }
//
//    func updateUIView(_ uiView: UITextField, context: Context) {
//        // Only update text if NOT currently focused and different
//        if !uiView.isFirstResponder && uiView.text != text {
//            uiView.text = text
//        }
//
//        uiView.backgroundColor = UIColor(backgroundColor)
//    }
//
//    class Coordinator: NSObject, UITextFieldDelegate {
//        var parent: AutoSelectTextField
//        static weak var currentFirstResponder: UITextField?
//
//        init(_ parent: AutoSelectTextField) {
//            self.parent = parent
//        }
//
//        @objc func didTapTextField(_ gesture: UITapGestureRecognizer) {
//            if let textField = gesture.view as? UITextField {
//                textField.becomeFirstResponder()
//                Coordinator.currentFirstResponder = textField
//                parent.onEditingBegan?()
//            }
//        }
//
//        func textFieldDidBeginEditing(_ textField: UITextField) {
//            Coordinator.currentFirstResponder = textField
//        }
//
//        func textFieldDidEndEditing(_ textField: UITextField) {
//            Coordinator.currentFirstResponder = nil
//        }
//    }
//}
