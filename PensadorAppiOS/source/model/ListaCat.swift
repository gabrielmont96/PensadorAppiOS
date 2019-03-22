//
//  ListaCat.swift
//  PensadorAppiOS
//
//  Created by stag on 21/03/19.
//  Copyright © 2019 Gabriel Silva. All rights reserved.
//

import ObjectMapper

final class ListaCat: Mappable {
    var nome: String?
    var urlAPI: String?
    var url: String?
    
    init() {}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        nome <- map["nome"]
        urlAPI <- map["url"]        
    }
}
