//
//  UIViewController+Extension.swift
//  OkBoarding
//
//  Created by Javier Gómez Ochoa on 04/09/2019.
//  Copyleft   2019 Javiochoa. Feel free to use it.
//

import UIKit

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        
        var hasTableView:Bool = false
        for subview in self.view.subviews {
            if subview is UITableView {
                hasTableView = true
                return
            }
        }
        if hasTableView == false {
            
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
            view.addGestureRecognizer(tap)
        }
    }
    
    //USE THIS WHEN THE VIEW HAS A TABLE VIEW OR SIMILAR TO ALLOW CELL TAP
    func removeHideKeyboardGesture() {
        
        if let recognizers = view.gestureRecognizers {
            for gr in recognizers {
                if let gRecognizer = gr as? UITapGestureRecognizer {
                    view.removeGestureRecognizer(gRecognizer)
                }
            }
        }
    }
    
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
    }
    
    func share(url: URL) {
        
        let documentInteractionController = UIDocumentInteractionController()
        documentInteractionController.delegate = self
        documentInteractionController.url = url
        documentInteractionController.uti = url.typeIdentifier ?? "public.data, public.content"
        documentInteractionController.name = url.localizedName ?? url.lastPathComponent
        documentInteractionController.presentPreview(animated: true)
    }
    
    func storeAndShare(withURLString: String) {
        
        guard let url = URL(string: withURLString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            let tmpURL = FileManager.default.temporaryDirectory
                .appendingPathComponent(response?.suggestedFilename ?? "fileName.png")
            do {
                try data.write(to: tmpURL)
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                self.share(url: tmpURL)
            }
        }.resume()
    }
}

extension UIViewController: UIDocumentInteractionControllerDelegate {
    /// If presenting atop a navigation stack, provide the navigation controller in order to animate in a manner consistent with the rest of the platform
    public func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        guard let navVC = self.navigationController else {
            return self
        }
        return navVC
    }
}
