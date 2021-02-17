//
//  ContactosViewController.swift
//  rplusapp
//
//  Created by Josué López on 12/8/20.
//

import UIKit
import ContactsUI
import RealmSwift

class ContactosViewController: UIViewController {
    
    @IBOutlet weak var tvContactos: UITableView!
    
    var contacts = [FetchedContact]()
    var contactosVerificados = [ContactosVerificados]()
    var contactosTelefonos = [String]()
    
//    var contactosFromDB = [sContactoObject]()
    var contactosFromDB = AppData.sharedData.getContactsObject()
    
    private var contactosVerificadosViewModel: ContactoVerificadoViewModel {
        ContactoVerificadoViewModel(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        contactosFromDB = AppData.sharedData.getContactsObject()
        self.tvContactos.setEditing(false, animated: true)
        self.tvContactos.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addContactsToArray(sentContacts: self.fetchContacts())
        self.saveContactsInLocal()
//        self.updateContactsFromWsToDB()
        
        
//        self.tvContactos.reloadData()
        
        // init loading
        //        initialMethod()
        
//        print(fetchContacts())
//        addContactsToArray(sentContacts: fetchContacts())
//        saveContactsInLocal()
//        loadContactsFromDB()
//        updateContactsFromWsToDB()
        ActivityIndicator.sharedIndicator.displayActivityIndicator(onView: self.view)
        
        contactosVerificados.forEach {
            print("aqui \($0.phone)")
            contactosTelefonos.append($0.phone)
        }
        
        contactosVerificadosViewModel.requestPostContactosVerificados(body: contactosTelefonos)
        
    }
    
    @IBAction func actionCrearPase(_ sender: UIButton) {
        
        // call Crear Pase
        let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "RegistroPaseViewController") as! RegistroPaseViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ContactosViewController {
    
    private func initialMethod() {
        
        
        // Tableview Set DataSource and DataDelegate
        //        tvContactos.dataSource = self
        //        tvContactos.delegate = self
        
        // init loading
        //        fetchContacts()
        
        //MARK: Adding contacts to array
        //        addContactsToArray()
        
        //MARK: Save contacts
        saveContactsInLocal()
        
//        DispatchQueue.main.async {
//            self.tvContactos.reloadData()
//        }
        
    }
    
    //MARK: Adding contacts to array
    private func addContactsToArray(sentContacts: [FetchedContact]) {
        
        for (index, contact) in sentContacts.enumerated() {
            print("ALELYA --> \(contact.firstName)")
            contactosVerificados.append(ContactosVerificados(idUser: "\(index)", phone: contact.telephone, existe: "0", verificado: "0", tipo: "0", avatar: contact.avatar, name: "\(contact.firstName) \(contact.lastName)"))
        }
        
        print("countContacts--> \(sentContacts.count)")
    }
    
    //MARK: Save contacts
    private func saveContactsInLocal() {
        // si base de datos de contactos es vacia guardar
        if (contactosFromDB.count == 0) {
            AppData.sharedData.saveContactosObject(arrContactos: contactosVerificados)
            print("--->GUARDAR<-----")
            
        }
    }
    
    private func loadContactsFromDB() {
    
        contactosFromDB = AppData.sharedData.getContactsObject()
    }
    
    private func updateContactsFromWsToDB() {
        
        contactosFromDB.forEach {
            print("- \($0.name) -")
//            AppData.sharedData.updateContactosObject(paramPhone: "\($0.phone)")
        }
        
        
    }
    
    func fetchContacts()-> [FetchedContact] {
        // 1.
        var contactsBlock = [FetchedContact]()
        
        let store = CNContactStore()
        
        // 2.
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactThumbnailImageDataKey]
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        do {
            // 3.
            try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
                
                contactsBlock.append(FetchedContact(firstName: contact.givenName, lastName: contact.familyName, telephone: contact.phoneNumbers.first?.value.stringValue ?? "", avatar: contact.thumbnailImageData))
                
                print("fetchContact ----> \(contact.phoneNumbers.first?.value.stringValue ?? "No existe numero")")
                
            })
        } catch let error {
            print("Failed to enumerate contact", error)
        }
        
        contactsBlock.sort(by: { $0.firstName < $1.firstName })
        
        
        
        
        return contactsBlock
    }
}


extension ContactosViewController: UITableViewDataSource {
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tvContactos.dequeueReusableCell(withIdentifier: "ContactosCell", for: indexPath as IndexPath) as! ContactosTableViewCell
        
        if contactosFromDB.count > 0 {
            
            let dataDB = contactosFromDB[indexPath.row]
            
            if dataDB.avatar != "" {
                
                let dataDecoded: Data = Data(base64Encoded: dataDB.avatar, options: .ignoreUnknownCharacters)!
                
                let decodedimage: UIImage = UIImage(data: dataDecoded)!
                cell.imgAvatar.image = decodedimage
                cell.imgAvatar.makeRounded()
            } else {
                cell.imgAvatar.image = UIImage(named: "IconCircle")
            }
            
            cell.lblName.text = dataDB.name
            cell.lblPhone.text = "\(dataDB.phone) - \(dataDB.tipo)"
            
            if (dataDB.existe == "0") {
                cell.lblBadge.setTitle("No registrado", for: .normal)
            } else {
                cell.lblBadge.setTitle("Registrado", for: .normal)
            }
            
            if (dataDB.verificado == "0") {
                cell.lblBadgeVerificado.setTitle("No verificado", for: .normal)
            } else {
                cell.lblBadgeVerificado.setTitle("\(dataDB.tipo)", for: .normal)
            }
            
            
            cell.lblBadge.customButton(bcColor: Constants.PaletteColors.colorFirst, borderRadius: Constants.App.cornerRadiusButton)
            cell.lblBadgeVerificado.customButton(bcColor: Constants.PaletteColors.colorSecond, borderRadius: Constants.App.cornerRadiusButton)
            
            return cell
            
        } else {
            
            let dataDBFirstTime = contactosVerificados[indexPath.row]
            
            if dataDBFirstTime.avatar != nil {
                
                let decodedimage = UIImage(data: dataDBFirstTime.avatar!)
                cell.imgAvatar.image = decodedimage
                cell.imgAvatar.makeRounded()
            } else {
                cell.imgAvatar.image = UIImage(named: "IconCircle")
            }
            
            cell.lblName.text = dataDBFirstTime.name
            cell.lblPhone.text = dataDBFirstTime.phone
            cell.lblBadge.setTitle("Agenda", for: .normal)
            
            cell.lblBadge.customButton(bcColor: Constants.PaletteColors.colorFirst, borderRadius: Constants.App.cornerRadiusButton)
            
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if contactosFromDB.count > 0 {
            return contactosFromDB.count
        } else {
            return contactosVerificados.count
        }
        
    }
}

extension ContactosViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dataDB = contactosFromDB[indexPath.row]
        
        let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "RegistroPaseViewController") as! RegistroPaseViewController
        vc.paramFromContacto = 1
        vc.paramContactoTelefono = dataDB.phone
        vc.paramContactoNombre = dataDB.name
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension ContactosViewController: ContactoVerificadoDelegate {
    func contactoVerificadoCompleted() {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
            print("fin de servicio contactos")
            self.tvContactos.reloadData()
        }
    }
    
    func contactoVerificadoCompleted(with error: String) {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
            AlertManager.showAlert(withMessage: error, title: "Error")
        }
    }

}
