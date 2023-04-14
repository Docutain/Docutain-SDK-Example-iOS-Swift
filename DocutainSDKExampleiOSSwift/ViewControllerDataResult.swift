//
//  ViewControllerDataResult.swift
//  DocutainSDKExampleiOSSwift
//
//  Created by Marvin Frankenfeld on 15.03.23.
//

import Foundation
import UIKit
import DocutainSdk

class ViewControllerDataResult : UIViewController{
    
    let loadingIndicator = UIActivityIndicatorView()
    lazy var textFieldName1 : UITextView = { return getTextView() }()
    lazy var textFieldName2 : UITextView = { return getTextView() }()
    lazy var textFieldName3 : UITextView = { return getTextView() }()
    lazy var textFieldZipcode : UITextView = { return getTextView() }()
    lazy var textFieldCity : UITextView = { return getTextView() }()
    lazy var textFieldStreet : UITextView = { return getTextView() }()
    lazy var textFieldPhone : UITextView = { return getTextView() }()
    lazy var textFieldCustomer : UITextView = { return getTextView()}()
    lazy var textFieldIBAN : UITextView = { return getTextView() }()
    lazy var textFieldBIC : UITextView = { return getTextView() }()
    lazy var textFieldDate : UITextView = { return getTextView() }()
    lazy var textFieldAmount : UITextView = { return getTextView() }()
    lazy var textFieldInvoiceID : UITextView = { return getTextView() }()
    lazy var textFieldReference : UITextView = { return getTextView() }()
    lazy var textFieldPaymentState : UITextView = { return getTextView() }()
    lazy var labelName1 : UILabel = { return getHeader() }()
    lazy var labelName2 : UILabel = { return getHeader() }()
    lazy var labelName3 : UILabel = { return getHeader() }()
    lazy var labelZipcode : UILabel = { return getHeader() }()
    lazy var labelCity : UILabel = { return getHeader() }()
    lazy var labelStreet : UILabel = { return getHeader() }()
    lazy var labelIBAN : UILabel = { return getHeader() }()
    lazy var labelPhone : UILabel = { return getHeader() }()
    lazy var labelCustomer : UILabel = { return getHeader() }()
    lazy var labelBIC : UILabel = { return getHeader() }()
    lazy var labelDate : UILabel = { return getHeader() }()
    lazy var labelAmount : UILabel = { return getHeader() }()
    lazy var labelInvoiceID : UILabel = { return getHeader() }()
    lazy var labelReference : UILabel = { return getHeader() }()
    lazy var labelPaymentState : UILabel = { return getHeader() }()
    let stackView = UIStackView()
    let scrollview = UIScrollView()
    private var stackViewWidthConstraint: NSLayoutConstraint?
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
        
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollview)
        NSLayoutConstraint.activate([
            scrollview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        labelName1.text = "Name1".localized()
        labelName2.text = "Name2".localized()
        labelName3.text = "Name3".localized()
        labelZipcode.text = "ZipCode".localized()
        labelCity.text = "City".localized()
        labelStreet.text = "Street".localized()
        labelPhone.text = "Phone".localized()
        labelCustomer.text = "CustomerID".localized()
        labelIBAN.text = "IBAN".localized()
        labelBIC.text = "BIC".localized()
        labelDate.text = "Date".localized()
        labelAmount.text = "Amount".localized()
        labelInvoiceID.text = "InvoiceID".localized()
        labelReference.text = "Reference".localized()
        labelPaymentState.text = "PaymentState".localized()
        
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.addArrangedSubview(labelName1)
        stackView.addArrangedSubview(textFieldName1)
        stackView.addArrangedSubview(labelName2)
        stackView.addArrangedSubview(textFieldName2)
        stackView.addArrangedSubview(labelName3)
        stackView.addArrangedSubview(textFieldName3)
        stackView.addArrangedSubview(labelZipcode)
        stackView.addArrangedSubview(textFieldZipcode)
        stackView.addArrangedSubview(labelCity)
        stackView.addArrangedSubview(textFieldCity)
        stackView.addArrangedSubview(labelStreet)
        stackView.addArrangedSubview(textFieldStreet)
        stackView.addArrangedSubview(labelCustomer)
        stackView.addArrangedSubview(textFieldCustomer)
        stackView.addArrangedSubview(labelIBAN)
        stackView.addArrangedSubview(textFieldIBAN)
        stackView.addArrangedSubview(labelBIC)
        stackView.addArrangedSubview(textFieldBIC)
        stackView.addArrangedSubview(labelDate)
        stackView.addArrangedSubview(textFieldDate)
        stackView.addArrangedSubview(labelAmount)
        stackView.addArrangedSubview(textFieldAmount)
        stackView.addArrangedSubview(labelInvoiceID)
        stackView.addArrangedSubview(textFieldInvoiceID)
        stackView.addArrangedSubview(labelReference)
        stackView.addArrangedSubview(textFieldReference)
        stackView.addArrangedSubview(labelPaymentState)
        stackView.addArrangedSubview(textFieldPaymentState)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollview.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollview.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: scrollview.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: scrollview.trailingAnchor, constant: -padding),
            stackView.bottomAnchor.constraint(equalTo: scrollview.bottomAnchor, constant: -padding)
        ])
        stackViewWidthConstraint = stackView.widthAnchor.constraint(equalToConstant: 0.0)
        stackViewWidthConstraint!.isActive = true
        
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.startAnimating()
        view.addSubview(loadingIndicator)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        if #available(iOS 13.0, *) {
            loadData()
        } else{
            print("Data Extraction is only available for iOS 13+")
        }
    }
    
    override func viewDidLayoutSubviews() {
        stackViewWidthConstraint?.constant = view.safeAreaLayoutGuide.layoutFrame.width - 2 * padding
    }
    
    @available(iOS 13.0, *)
    private func loadData(){
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = self.documentUrl{
                //if an url is available it means we have imported a file. If so, we need to load it into the SDK first
                if(!DocumentDataReader.loadFile(fileUrl: url)){
                    //an error occured, get the latest error message
                    print("DocumentDataReader.loadFile failed with error: \(DocutainSDK.getLastError())")
                    return
                }
            }
            //analyze the currently loaded document and get the detected data
            let analyzeData = DocumentDataReader.analyze()
            if(analyzeData.isEmpty){
                print("no data detected")
                return
            }
            do{
                //detected data is returned as JSON, so serializing the data in order to extract the key value pairs
                //see [https://docs.docutain.com/docs/iOS/dataExtraction] for more information
                if let jsonArray = try JSONSerialization.jsonObject(with: Data(analyzeData.utf8), options : []) as? [String: Any]
                {
                    let address = jsonArray["Address"] as! [String: Any]
                    let name1 = address["Name1"] as? String ?? ""
                    let name2 = address["Name2"] as? String ?? ""
                    let name3 = address["Name3"] as? String ?? ""
                    let zipcode = address["Zipcode"] as? String ?? ""
                    let city = address["City"] as? String ?? ""
                    let street = address["Street"] as? String ?? ""
                    let phone = address["Phone"] as? String ?? ""
                    let customerId = address["CustomerId"] as? String ?? ""
                    var IBAN = ""
                    var BIC = ""
                    let bank = address["Bank"] as! [[String: Any]]
                    //TODO: handle multiple bank accounts
                    if(bank.count > 0){
                        IBAN = bank[0]["IBAN"] as? String ?? ""
                        BIC = bank[0]["BIC"] as? String ?? ""
                    }
                    let date = jsonArray["Date"] as? String ?? ""
                    let amount = jsonArray["Amount"] as? String ?? ""
                    let invoiceId = jsonArray["InvoiceId"] as? String ?? ""
                    let reference = jsonArray["Reference"] as? String ?? ""
                    let paid = jsonArray["PaymentState"] as? String ?? ""
                    
                    DispatchQueue.main.async {
                        self.loadingIndicator.stopAnimating()
                        self.textFieldName1.text = name1
                        self.textFieldName1.isHidden = name1.isEmpty
                        self.labelName1.isHidden = name1.isEmpty
                        self.textFieldName2.text = name2
                        self.textFieldName2.isHidden = name2.isEmpty
                        self.labelName2.isHidden = name2.isEmpty
                        self.textFieldName3.text = name3
                        self.textFieldName3.isHidden = name3.isEmpty
                        self.labelName3.isHidden = name3.isEmpty
                        self.textFieldZipcode.text = zipcode
                        self.textFieldZipcode.isHidden = zipcode.isEmpty
                        self.labelZipcode.isHidden = zipcode.isEmpty
                        self.textFieldCity.text = city
                        self.textFieldCity.isHidden = city.isEmpty
                        self.labelCity.isHidden = city.isEmpty
                        self.textFieldStreet.text = street
                        self.textFieldStreet.isHidden = street.isEmpty
                        self.labelStreet.isHidden = street.isEmpty
                        self.textFieldPhone.text = phone
                        self.textFieldPhone.isHidden = phone.isEmpty
                        self.labelPhone.isHidden = phone.isEmpty
                        self.textFieldCustomer.text = customerId
                        self.textFieldCustomer.isHidden = customerId.isEmpty
                        self.labelCustomer.isHidden = customerId.isEmpty
                        do{
                            let IBANRegex = try NSRegularExpression(pattern: ".{4}")
                            IBAN = IBANRegex.stringByReplacingMatches(in: IBAN, range: NSMakeRange(0, IBAN.count), withTemplate: "$0 ")
                        } catch let regexError as NSError {
                            print(regexError)
                        }
                        self.textFieldIBAN.text = IBAN
                        self.textFieldIBAN.isHidden = IBAN.isEmpty
                        self.labelIBAN.isHidden = IBAN.isEmpty
                        self.textFieldBIC.text = BIC
                        self.textFieldBIC.isHidden = BIC.isEmpty
                        self.labelBIC.isHidden = BIC.isEmpty
                        self.textFieldDate.text = date
                        self.textFieldDate.isHidden = date.isEmpty
                        self.labelDate.isHidden = date.isEmpty
                        self.textFieldAmount.text = amount
                        self.textFieldAmount.isHidden = amount.isEmpty || amount == "0.00"
                        self.labelAmount.isHidden = amount.isEmpty || amount == "0.00"
                        self.textFieldInvoiceID.text = invoiceId
                        self.textFieldInvoiceID.isHidden = invoiceId.isEmpty
                        self.labelInvoiceID.isHidden = invoiceId.isEmpty
                        self.textFieldReference.text = reference
                        self.textFieldReference.isHidden = reference.isEmpty
                        self.labelReference.isHidden = reference.isEmpty
                        self.textFieldPaymentState.text = paid
                        self.textFieldPaymentState.isHidden = paid.isEmpty
                        self.labelPaymentState.isHidden = paid.isEmpty
                    }
                } else {
                    print("JSON serialization failed")
                }
            } catch let error as NSError {
                print(error)
            }
        }
    }
    
    private func getHeader() -> UILabel{
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.isHidden = true
        return label
    }
    
    private func getTextView() -> UITextView{
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.isEditable = false
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.layer.borderColor = UIColor.systemGray.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 8
        textView.isHidden = true
        return textView
    }
}
