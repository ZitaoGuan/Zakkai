//
//  SubscriptionModel.swift
//  Zakkai
//
//  Created by Zitao Guan on 2/7/24.
//

import SwiftUI

struct SubscriptionModel: Identifiable, Equatable {
   
    var id: UUID = UUID()
    var itemId: Int = 0
    var name: String = ""
    var price: String = ""
    var icon: String = ""
    
    
    init(dict: NSDictionary) {
        self.itemId  = dict.value(forKey: "id") as? Int ?? 0
        self.name = dict.value(forKey: "name") as? String ?? ""
        self.price = dict.value(forKey: "price") as? String ?? ""
        self.icon = dict.value(forKey: "icon") as? String ?? ""
    }
    
    static func == (lhs: SubscriptionModel, rhs: SubscriptionModel) -> Bool {
        return lhs.id == rhs.id
    }
    
}

