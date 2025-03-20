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
