//
//  ContactosViewController.swift
//  rplusapp
//
//  Created by Josué López on 12/8/20.
//

import UIKit
import ContactsUI
//import RealmSwift

struct FetchedContact {
    var firstName: String
    var lastName: String
    var telephone: String
    var avatar: Data?
}

struct ContactosVerificados {
    var idUser: String
    var phone: String
    var existe: String
    var verificado: String // borrar este key, si ya esta clasificado
    var tipo: String // que tipo de visita es
    var avatar: Data?
    var name: String
    
}

class ContactosViewController: UIViewController {
    
    @IBOutlet weak var tvContactos: UITableView!
    
    var contacts = [FetchedContact]()
    var contactosVerificados = [ContactosVerificados]()
    
    var contactosFromDB = AppData.sharedData.getContactsObject()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // init loading
        initialMethod()
        
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
        tvContactos.dataSource = self
        tvContactos.delegate = self
        
        // init loading
        fetchContacts()
        contacts.sort(by: { $0.firstName < $1.firstName })
        contactosVerificados.sort(by: { $0.name < $1.name })
        
        
        for (index, contact) in contacts.enumerated() {
            print("ALELYA --> \(contact.firstName)")
            contactosVerificados.append(ContactosVerificados(idUser: "\(index)", phone: contact.telephone, existe: "0", verificado: "0", tipo: "0", avatar: contact.avatar, name: "\(contact.firstName) \(contact.lastName)"))
        }
        
        print("JJJJ--> \(contactosVerificados.count)")
        
        // si base de datos de contactos es vacia guardar
        if (contactosFromDB.count == 0) {
            AppData.sharedData.saveContactosObject(arrContactos: contactosVerificados)
            print("--->GUARDAR<-----")
            
        }
        
        DispatchQueue.main.async {
            self.tvContactos.reloadData()
        }
        
    }
    
    private func fetchContacts() {
        // 1.
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, error) in
            if let error = error {
                print("failed to request access", error)
                return
            }
            if granted {
                // 2.
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactThumbnailImageDataKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                do {
                    // 3.
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
                        
                        self.contacts.append(FetchedContact(firstName: contact.givenName, lastName: contact.familyName, telephone: contact.phoneNumbers.first?.value.stringValue ?? "", avatar: contact.thumbnailImageData))
//                        DispatchQueue.main.async {
//                            self.tvContactos.reloadData()
//                        }
                        print("BAM ---->")
                        
                    })
                } catch let error {
                    print("Failed to enumerate contact", error)
                }
            } else {
                print("access denied")
            }
        }
    }
}

extension ContactosViewController: UITableViewDataSource {
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tvContactos.dequeueReusableCell(withIdentifier: "ContactosCell", for: indexPath as IndexPath) as! ContactosTableViewCell
        
        //if contactosFromDB.count > 0 {
            
            let avatarDataDb = Data(contactosFromDB[indexPath.row].avatar.utf8)
            
            if contactosFromDB[indexPath.row].avatar != "" {
                
                let decodedimage = UIImage(data: avatarDataDb)
                cell.imgAvatar.image = decodedimage
                cell.imgAvatar.makeRounded()
            } else {
                cell.imgAvatar.image = UIImage(named: "IconCircle")
            }
            
            cell.lblName.text = contactosFromDB[indexPath.row].name
            cell.lblPhone.text = contactosFromDB[indexPath.row].phone
            
            cell.lblBadge.customButton(bcColor: Constants.PaletteColors.statusGreen, borderRadius: Constants.App.cornerRadiusButton)
            
            return cell
            
        /*} else {
            
            
            if contacts[indexPath.row].avatar != nil {
                
                let decodedimage = UIImage(data: contacts[indexPath.row].avatar!)
                cell.imgAvatar.image = decodedimage
                cell.imgAvatar.makeRounded()
            } else {
                cell.imgAvatar.image = UIImage(named: "IconCircle")
            }
            
            cell.lblName.text = contacts[indexPath.row].firstName
            cell.lblPhone.text = contacts[indexPath.row].telephone
            
            cell.lblBadge.customButton(bcColor: Constants.PaletteColors.statusGreen, borderRadius: Constants.App.cornerRadiusButton)
            
            return cell
            
        }*/
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //if contactosFromDB.count > 0 {
            return contactosFromDB.count
//        } else {
//            return contacts.count
//        }
//
       
        
        
    }
}

extension ContactosViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
