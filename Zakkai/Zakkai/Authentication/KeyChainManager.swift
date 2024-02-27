//
//  KeyChainManager.swift
//  Zakkai
//
//  Created by Noah Giboney on 2/26/24.
//

import SwiftUI

@propertyWrapper
struct KeyChain: DynamicProperty {
    
    @State private var data: Data?
    
    var wrappedValue: Data? {
        get{data}
        set {
            
            guard let newData = newValue else {
                data = nil
                KeyChainManager.standard.delete(key: key, account: account)
                return
            }
            
            KeyChainManager.standard.save(data: newData, key: key, account: account)
        }
    }
    
    var key: String
    var account: String
    
    init(key: String, account: String){
        self.key = key
        self.account = account
        
        _data = State(wrappedValue: KeyChainManager.standard.read(key: key, account: account))
    }
}

class KeyChainManager {

    static let standard = KeyChainManager()
    
    // write data to the keychain
    func read(key: String, account: String) -> Data?  {
        let query = [
        
            kSecAttrAccount: account,
            kSecAttrService: key,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var resultData: AnyObject?
        SecItemCopyMatching(query, &resultData )
        
        return (resultData as? Data)
        
    }

    
    // save data to keychian
    func save(data: Data, key: String, account: String ) {
         
        // create a query
        let query = [
            kSecValueData: data,
            kSecAttrAccount: account,
            kSecAttrService: key,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        
        // adding data to keychain
        let status  = SecItemAdd(query, nil)
        
        // check for status
        
        switch status{
        case errSecSuccess: print("succesful stored in key chain")
            
            //update data
        case errSecDuplicateItem:
            let updateQuery = [
            
                kSecValueData: data,
                kSecAttrAccount: account,
                kSecAttrService: key,
                kSecClass: kSecClassGenericPassword
            ] as CFDictionary
            
            let updateAtrb = [kSecValueData: data] as CFDictionary
            
            SecItemUpdate(updateQuery, updateAtrb)
            
        default: print("error storing in keychain")
        }
    }
    
    // delete data from the keychain
    func delete(key: String, account: String) {
        let query = [
            kSecAttrAccount: account,
            kSecAttrService: key,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        
        SecItemDelete(query)
    }
}
