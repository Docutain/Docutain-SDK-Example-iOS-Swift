//
//  ViewController.swift
//  DocutainSDKExampleiOSSwift
//
//  Created by Marvin Frankenfeld on 15.03.23.
//

import UIKit
import Photos
import PhotosUI
import MobileCoreServices
import DocutainSdk

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIDocumentInteractionControllerDelegate, PHPickerViewControllerDelegate, UIDocumentPickerDelegate, ScanDelegate {

    struct ListItem {
        var title : String
        var icon : String
        var subtitle : String
        var itemType: ItemType
    }
    
    let listItems : [ListItem] = [ListItem](arrayLiteral: ListItem(title: "title_document_scan".localized(), icon: "DocumentScanner", subtitle: "subtitle_document_scan".localized(), itemType: ItemType.documentScan), ListItem(title: "title_data_extraction".localized(), icon: "DataExtraction", subtitle: "subtitle_data_extraction".localized(), itemType: ItemType.dataExtraction), ListItem(title: "title_text_recognition".localized(), icon: "OCR", subtitle: "subtitle_text_recognition".localized(), itemType: ItemType.textRecognition), ListItem(title: "title_PDF_generating".localized(), icon: "PDF", subtitle: "subtitle_PDF_generating".localized(), itemType: ItemType.pdfGenerating), ListItem(title: "title_settings".localized(), icon: "Settings", subtitle: "subtitle_settings".localized(), itemType: ItemType.settings))
       
    let cellReuseIdentifier = "cell"
    let tableView = UITableView()
    
    enum ItemType {
        case none
        case documentScan
        case dataExtraction
        case textRecognition
        case pdfGenerating
        case settings
    }
    
    private var selectedOption = ItemType.none
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.backButtonTitle = ""
        title = "Docutain SDK Example"
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            // Fallback on earlier versions
            view.backgroundColor = .white
        }
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        self.tableView.register(TableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func startScan(){
        //define a DocumentScannerConfiguration to alter the scan process and define a custom theme to match your branding
        let scanConfig = getScanConfig()
        //start the scanner using the provided config
        UI.scanDocument(scanDelegate: self, scanConfig: scanConfig)
    }
    
    private func getScanConfig(imageImport: Bool = false) ->DocumentScannerConfiguration{
        
        //There are a lot of settings to configure the scanner to match your specific needs
        //Check out the documentation to learn more https://docs.docutain.com/docs/iOS/docScan#change-default-scan-behaviour
        
        let scanConfig = DocumentScannerConfiguration()
        
        if(imageImport){
            if #available(iOS 14, *) {
                scanConfig.source = .galleryMultiple
            } else {
                // Fallback on earlier versions
                scanConfig.source = .gallery
            }
        }
        
        //In this sample app we provide a settings page which the user can use to alter the scan settings
        //The settings are stored in and read from "DocutainPreferences"
        //This is supposed to be just an example, you do not need to implement it in that exact way
        //If you do not want to provide your users the possibility to alter the settings themselves at all
        //You can just set the settings according to the apps needs
        
        //set scan settings
        scanConfig.allowCaptureModeSetting = DocutainPreferences.AllowCaptureModeSetting
        scanConfig.autoCapture = DocutainPreferences.AutoCapture
        scanConfig.autoCrop = DocutainPreferences.AutoCrop
        scanConfig.multiPage = DocutainPreferences.MultiPage
        scanConfig.defaultScanFilter = DocutainPreferences.DefaultScanFilter
        
        //set edit settings
        scanConfig.pageEditConfig.allowPageFilter = DocutainPreferences.AllowPageFilter
        scanConfig.pageEditConfig.allowPageRotation = DocutainPreferences.AllowPageRotation
        scanConfig.pageEditConfig.allowPageCropping = DocutainPreferences.AllowPageCropping
        scanConfig.pageEditConfig.allowPageArrangement = DocutainPreferences.AllowPageArrangement
        scanConfig.pageEditConfig.pageArrangementShowPageNumber = DocutainPreferences.PageArrangementShowPageNumber
        scanConfig.pageEditConfig.pageArrangementShowDeleteButton = DocutainPreferences.PageArrangementShowDeleteButton
        
        //set color settings
        scanConfig.colorConfig.setColorPrimary(light: DocutainPreferences.ColorPrimary.light, dark: DocutainPreferences.ColorPrimary.dark)
        scanConfig.colorConfig.setColorSecondary(light: DocutainPreferences.ColorSecondary.light, dark: DocutainPreferences.ColorSecondary.dark)
        scanConfig.colorConfig.setColorOnSecondary(light: DocutainPreferences.ColorOnSecondary.light, dark: DocutainPreferences.ColorOnSecondary.dark)
        scanConfig.colorConfig.setColorScanButtonsLayoutBackground(light: DocutainPreferences.ColorScanButtonsLayoutBackground.light, dark: DocutainPreferences.ColorScanButtonsLayoutBackground.dark)
        scanConfig.colorConfig.setColorScanButtonsForeground(light: DocutainPreferences.ColorScanButtonsForeground.light, dark: DocutainPreferences.ColorScanButtonsForeground.dark)
        scanConfig.colorConfig.setColorScanPolygon(light: DocutainPreferences.ColorScanPolygon.light, dark: DocutainPreferences.ColorScanPolygon.dark)
        scanConfig.colorConfig.setColorBottomBarBackground(light: DocutainPreferences.ColorBottomBarBackground.light, dark: DocutainPreferences.ColorBottomBarBackground.dark)
        scanConfig.colorConfig.setColorBottomBarForeground(light: DocutainPreferences.ColorBottomBarForeground.light, dark: DocutainPreferences.ColorBottomBarForeground.dark)
        scanConfig.colorConfig.setColorTopBarBackground(light: DocutainPreferences.ColorTopBarBackground.light, dark: DocutainPreferences.ColorTopBarBackground.dark)
        scanConfig.colorConfig.setColorTopBarForeground(light: DocutainPreferences.ColorTopBarForeground.light, dark: DocutainPreferences.ColorTopBarForeground.dark)
        
        //alter the onboarding image source if you like
        //scanConfig.onboardingImageSource = ...
        
        //detailed information about theming possibilities can be found here [https://docs.docutain.com/docs/iOS/theming]
        return scanConfig
    }
    
    private func startPDFImport(){
        let types: [String] = [kUTTypePDF as String]
        let documentPicker = UIDocumentPickerViewController(documentTypes: types, in: .import)
        documentPicker.delegate = self
        self.present(documentPicker, animated: true, completion: nil)
    }
    
    private func startImageImport(){
        //define a DocumentScannerConfiguration to alter the scan process and define a custom theme to match your branding
        let scanConfig = getScanConfig(imageImport: true)
        //start the scanner using the provided config
        UI.scanDocument(scanDelegate: self, scanConfig: scanConfig)
    }
    
    private func startDataExtraction(){
        showInputOptionAlert()
    }
    
    private func startTextRecognition(){
        showInputOptionAlert()
    }
    
    private func startPDFGenerating(){
        showInputOptionAlert()
    }
    
    private func showInputOptionAlert(){
        let alert = UIAlertController(title: "Info", message: "input_option_message".localized(), preferredStyle: .actionSheet)
        if let popoverController = alert.popoverPresentationController{
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        alert.addAction(UIAlertAction(title: "input_option_scan".localized(), style: .default, handler: {_ in
            self.startScan()
        }))
        alert.addAction(UIAlertAction(title: "input_option_PDF".localized(), style: .default, handler: {_ in
            self.startPDFImport()
        }))
        alert.addAction(UIAlertAction(title: "input_option_Image".localized(), style: .default, handler: {_ in
            self.startImageImport()
        }))
        alert.addAction(UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: {_ in
            
        }))
        present(alert, animated: true)
    }
    
    private func generatePDF(url: URL?){
        DispatchQueue.global(qos: .userInitiated).async {
            if let documentUrl = url{
                //if an url is available it means we have imported a file. If so, we need to load it into the SDK first
                if #available(iOS 13.0, *) {
                    //searchable PDF files are only available for iOS 13+
                    if(!DocumentDataReader.loadFile(fileUrl: documentUrl)){
                        //an error occured, get the latest error message
                        print("DocumentDataReader.loadFile failed with error: \(DocutainSDK.getLastError())")
                        return
                    }
                } else {
                    //load for non searchable PDF
                    if(!Document.loadFile(fileUrl: documentUrl)){
                        //an error occured, get the latest error message
                        print("Document.loadFile failed with error: \(DocutainSDK.getLastError())")
                        return
                    }
                }
            }
            //define the output path for the PDF
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let path = paths[0]
            //generate the PDF from the currently loaded document
            //the generated PDF also contains the detected text, making the PDF searchable
            //see [https://docs.docutain.com/docs/iOS/pdfCreation] for more details
            if let pdfUrl = Document.writePDF(fileUrl: path, fileName: "DocutainSDK", overwrite: true, pageFormat: .A4){
                //displaying the generated PDF for demonstration purposes
                let dc = UIDocumentInteractionController(url: pdfUrl)
                dc.delegate = self
                DispatchQueue.main.async {
                    dc.presentPreview(animated: true)
                }
            } else{
                print("Writing PDF file failed, last error: \(DocutainSDK.getLastError())")
            }
        }
    }
    
    private func openDataResultViewController(url: URL?){
        navigationController!.pushViewController(ViewControllerDataResult(url: url), animated: true)
    }
    
    private func openTextResultViewController(url: URL?){
        navigationController!.pushViewController(ViewControllerTextResult(url:url), animated: true)
    }
    
    private func proceedBasedOnCurrentSelection(url: URL?){
        switch selectedOption{
            case ItemType.pdfGenerating:
                generatePDF(url: url)
            case ItemType.dataExtraction:
                openDataResultViewController(url:url)
            case ItemType.textRecognition:
                openTextResultViewController(url:url)
            default:
                print("Select an input option first")
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listItems.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! TableViewCell
        let item = self.listItems[indexPath.row]
        if #available(iOS 13.0, *) {
            let config = UIImage.SymbolConfiguration(weight: .light)
            let image = UIImage(named: item.icon)?.withConfiguration(config)
            cell.icon.image = image
        } else {
            cell.icon.image = UIImage(named: item.icon)
        }
        cell.title.text = item.title
        cell.subtitle.text = item.subtitle
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedItem = self.listItems[indexPath.row]
        switch selectedItem.itemType {
            case ItemType.documentScan:
                selectedOption = ItemType.none
                startScan()
            case ItemType.dataExtraction:
                selectedOption = ItemType.dataExtraction
                startDataExtraction()
            case ItemType.textRecognition:
                selectedOption = ItemType.textRecognition
                startTextRecognition()
            case ItemType.pdfGenerating:
                selectedOption = ItemType.pdfGenerating
                startPDFGenerating()
            case ItemType.settings:
                selectedOption = ItemType.none
                navigationController!.pushViewController(ViewControllerSettings(), animated: true)
            default:
                selectedOption = ItemType.none
                print("Invalid item selected")
        }
    }
    
    func didFinishScan(withResult: Bool) {
        if(withResult){
            switch selectedOption{
            case ItemType.pdfGenerating:
                generatePDF(url:nil)
            case ItemType.dataExtraction:
                openDataResultViewController(url:nil)
            case ItemType.textRecognition:
                openTextResultViewController(url:nil)
            default:
                print("Select an input option first")
            }
        } else{
            print("canceled scan process")
        }
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self//or use return self.navigationController for fetching app navigation bar colour
    }
    
    //pdf import
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        dismiss(animated: true)
        proceedBasedOnCurrentSelection(url: url)
    }
    
    //image picker
    @available(iOS 14.0, *)
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        if(results.count == 0){
            print("image import canceled")
        } else{
            results[0].itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { url, error in
                do {
                    guard let url = url, error == nil else {
                        throw error ?? NSError(domain: NSFileProviderErrorDomain, code: -1, userInfo: nil)
                    }
                    let localURL = FileManager.default.temporaryDirectory.appendingPathComponent(url.lastPathComponent)
                    try? FileManager.default.removeItem(at: localURL)
                    try FileManager.default.copyItem(at: url, to: localURL)
                    DispatchQueue.main.async {
                        self.proceedBasedOnCurrentSelection(url: localURL)
                    }
                } catch let catchedError {
                    print("image import failed with error: \(catchedError)")
                }
            }
        }
    }
}

