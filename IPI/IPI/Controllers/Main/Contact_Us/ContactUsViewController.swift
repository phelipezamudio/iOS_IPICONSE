//
//  ContactUsViewController.swift
//  IPI
//
//  Created by Felipe Zamudio on 07/05/19.
//  Copyright © 2019 NRC. All rights reserved.
//

import UIKit
import ObjectMapper

class ContactUsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ContactUsViewControllerDelegate {

    // MARK: - Outlets
    @IBOutlet var contact_tableView : UITableView!

    // MARK: - Properties
    weak var mainDelegate: MainProtocol?

    var messageTypeList: Array<ContactFormType> = []
    var message: String = nullString

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Get picker and mainDelegate form options from runtime
        messageTypeList = AplicationRuntime.sharedManager.getContactFormTypeList()
        mainDelegate = AplicationRuntime.sharedManager.mainDelegate

        //It's added observable to scroll view when the keyboard is shown / hidden
        NotificationCenter.default.removeObserver(Any.self)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification , object: nil)

        // Add delegate and Data Source to itself
        self.contact_tableView.delegate = self
        self.contact_tableView.dataSource = self
        self.contact_tableView.isScrollEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Action for Gestures
    //Observer for increment contentSize in the tableView
    @objc func keyboardWillShow(notification: NSNotification) {
        self.singin_tableView.isScrollEnabled = true
    }

    //Obeserver for move frame to origin when keyboard is hiden
    @objc func keyboardWillHide(notification: NSNotification) {
        singin_tableView.isScrollEnabled = false
    }

    // MARK: - TableView delegate and datasource
    // Número de secciones de la tabla
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Número de filas
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    // Se agrega la propiedad para ajustar el tamaño de la celda al contenido
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.bounds.height < 640 {
            return UITableView.automaticDimension
        }
        else {
            return tableView.bounds.height
        }
    }

    // Tamaño estimado de las celdas
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height
    }

    // pintado de la tabla
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.contactUsCell.rawValue, for: indexPath) as! ContactUsTableViewCell

        cell.contactDelegate = self
        cell.messageTypeList = self.messageTypeList
        cell.fillCell()

        return cell
    }

    // MARK: - Singin Dalegate
    func sendMessage(withMessage msn: String) {
        self.showErrorMessage(withMessage: msn)
    }

    func sendRequest(contactForm: ContactForm) {

        let json = Mapper().toJSONString(contactForm, prettyPrint: true)
        let token = NetworkConfig.token + AplicationRuntime.sharedManager.getUserToken()

        var headers: [[String:String]] = []
        headers.append([NetworkConfig.headerName: NetworkConfig.headerAuthorization,
                        NetworkConfig.headerValue: token])

        Network.buildRequest(urlApi: NetworkPOST.CONTACT_FORM, json: json, extraHeaders: headers, method: .methodPOST, completion: { (response) in

            switch response {

            case .succeeded(let succeed, let message):
                if !succeed {
                    printDebugMessage(tag: message)
                    self.showErrorMessage(withMessage: message)
                }
                break

            case .error(let error):
                print(error.debugDescription)
                break

            case .succeededObject(let objReceiver):

                _ = Mapper<ContactForm>().map(JSON: objReceiver as! [String: Any])

                self.contact_tableView.reload()
                self.mainDelegate?.showMessageInMain(withMessage: Labels.message_ok_contact)

                break

            default:
                break
            }
        })

    }
}