//
//  ListaCat.swift
//  PensadorAppiOS
//
//  Created by Gabriel Silva on 21/03/19.
//  Copyright © 2019 Gabriel Silva. All rights reserved.
//

import ObjectMapper

final class ListCat: Mappable {
    var name: String?
    var urlAPI: String?
    var url: String?
    
    init() {}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        name <- map["nome"]
        urlAPI <- map["url"]        
    }
}
