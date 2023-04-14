//
//  ViewControllerTextResult.swift
//  DocutainSDKExampleiOSSwift
//
//  Created by Marvin Frankenfeld on 15.03.23.
//

import Foundation
import UIKit
import DocutainSdk

class ViewControllerTextResult : UIViewController{
    
    let loadingIndicator = UIActivityIndicatorView()
    let textView = UITextView()
    let padding = 16.0
    var documentUrl : URL?
    
    init(url: URL?){
        documentUrl = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        navigationItem.backButtonTitle = ""
        title = "Docutain SDK Example"
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            // Fallback on earlier versions
            view.backgroundColor = .white
        }
        
        textView.isEditable = false
        textView.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding).isActive = true
        
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.startAnimating()
        view.addSubview(loadingIndicator)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        if #available(iOS 13.0, *) {
            loadText()
        } else{
            print("Text Recognition is only available for iOS 13+")
        }
    }
    
    @available(iOS 13.0, *)
    private func loadText(){
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = self.documentUrl{
                //if an url is available it means we have imported a file. If so, we need to load it into the SDK first
                if(!DocumentDataReader.loadFile(fileUrl: url)){
                    //an error occured, get the latest error message
                    print("DocumentDataReader.loadFile failed with error: \(DocutainSDK.getLastError())")
                    return
                }
            }
            //get the text of all currently loaded pages
            //if you want text of just one specific page, define the page number
            //see [https://docs.docutain.com/docs/iOS/textDetection] for more details
            let text = DocumentDataReader.getText()
            DispatchQueue.main.async {
                self.loadingIndicator.stopAnimating()
                self.textView.text = text
            }
        }
    }
}
