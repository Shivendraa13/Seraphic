//
//  KeyboardHandler.swift
//  Seraphic Design
//
//  Created by Shivendra on 12/12/24.
//

import UIKit

class KeyboardHandler: NSObject {
    private weak var scrollView: UIScrollView?
    private var activeTextField: UITextField?

    init(scrollView: UIScrollView) {
        self.scrollView = scrollView
        super.init()
        registerForKeyboardNotifications()
    }

    deinit {
        deregisterFromKeyboardNotifications()
    }

    func registerTextField(_ textField: UITextField) {
        textField.delegate = self
    }

    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func deregisterFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let scrollView = scrollView,
              let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        // Adjust the scroll view to make the text field visible
        var visibleRect = scrollView.frame
        visibleRect.size.height -= keyboardSize.height
        if let activeField = activeTextField, !visibleRect.contains(activeField.frame.origin) {
            scrollView.scrollRectToVisible(activeField.frame, animated: true)
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
}

extension KeyboardHandler: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }
}
