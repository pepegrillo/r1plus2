//
//  AppData.swift
//  rplusapp
//
//  Created by Josué López on 11/9/20.
//  Copyright © 2020 Josué López. All rights reserved.
//

import UIKit
import RealmSwift

class sShowcase:Object {
    @objc dynamic var id: String = ""
    @objc dynamic var parameter: String = "0"
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class sContactoObject: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var idUser: String = "0"
    @objc dynamic var phone: String = ""
    @objc dynamic var existe: String = "0"
    @objc dynamic var verificado: String = "0"
    @objc dynamic var tipo: String = "0"
    @objc dynamic var avatar: String = ""
    @objc dynamic var name: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class AppData {
    
    static let sharedData = AppData()
    
    var allUserData = LoginRplus() {
        didSet {
            // Persist Data
            saveUserData()
        }
    }
    
    // remember shows Showcase once
    func saveShowcase(in realm: Realm = try! Realm(configuration: Utilities.bundleRealmConfig)) {
        let param = sShowcase()
        param.parameter = "1"
        do {
            try realm.write {
                realm.add(param, update: .all)
            }
        } catch let e as NSError {
            print(e.description)
        }
    }
    
    func getSaveShowcase(in realm: Realm = try! Realm(configuration: Utilities.bundleRealmConfig)) -> String {
        let param = realm.objects(sShowcase.self)
        return param.first?.parameter ?? ""
    }
    
    // save contactos
    func saveContactosObject(arrContactos: [ContactosVerificados], in realm: Realm = try! Realm(configuration: Utilities.bundleRealmConfig)) {
        
        do {
            realm.beginWrite()
            
            for data in arrContactos {
                
                let dataArr = sContactoObject()
                dataArr.id = UUID().uuidString
                dataArr.idUser = data.idUser
                dataArr.phone = data.phone
                dataArr.existe = data.existe
                dataArr.verificado = data.verificado
                dataArr.tipo = data.tipo
                dataArr.avatar = data.avatar?.base64EncodedString() ?? ""
                dataArr.name = data.name
                
                realm.add(dataArr, update: .all)
                print("guardandoxAOBJKECT----> \(dataArr)")
            }
            
            try realm.commitWrite()
            
        } catch let e as NSError {
            print(e.description)
        }
    }
    
    func removeContactosObject(in realm: Realm = try! Realm(configuration: Utilities.bundleRealmConfig)) {
        do {
            let contacto = realm.objects(sContactoObject.self)
            try realm.write {
                realm.delete(contacto)
            }
        } catch let e as NSError {
            print(e.description)
        }
    }
    
    
    func getContactsObject(in realm: Realm = try! Realm(configuration: Utilities.bundleRealmConfig)) -> [sContactoObject] {
        let contact = realm.objects(sContactoObject.self)
        print(contact.count)
        return Array(contact)
    }
    
    
    func saveUserData() {
        if let encoded = try? JSONEncoder().encode(allUserData) {
            UserDefaults.standard.set(encoded, forKey: Constants.App.userData)
            //print("baby \(allUserData.content?.jwtResponse?.token)")
        }
    }
    
    func getUserData() -> LoginRplus? {
        if let data = UserDefaults.standard.object(forKey: Constants.App.userData) as? Data {
            if let loadedUserData = try? JSONDecoder().decode(LoginRplus.self, from: data) {
                allUserData = loadedUserData
                return allUserData
                //print(allUserData)
            }
        }
        return nil
    }
    
    func saveImageRegistro(image64: String) {
        UserDefaults.standard.set(image64, forKey: Constants.App.image64Registro)
    }
    
    // save id residencial for get other WS
    func saveIdResidencial(paramIdResidencial: String) {
        UserDefaults.standard.set(paramIdResidencial, forKey: Constants.App.saveIdResidencial)
    }
    
    
    
    func removeAllUserDefaults() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        //        print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
        
        UserDefaults.standard.set(GlobalParameters.instance().globalAppleEmail, forKey: "userEmail")
        UserDefaults.standard.set(GlobalParameters.instance().globalAppleName, forKey: "userName")
    }
    
    
    // MARK: Save data Facebook SDK
    func saveUserFacebookData(data: [String: AnyObject]) {
        UserDefaults.standard.set(data, forKey: Constants.App.bdFacebookData)
    }
    
    
    func getUserFacebookData() -> [String: AnyObject] {
        let defaults = UserDefaults.standard
        let myarray = defaults.object(forKey: Constants.App.bdFacebookData)
        
        return myarray as! [String : AnyObject]
    }
}
