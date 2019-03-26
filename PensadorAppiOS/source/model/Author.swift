//
//  Author.swift
//  PensadorAppiOS
//
//  Created by Gabriel Silva on 25/03/19.
//  Copyright © 2019 Gabriel Silva. All rights reserved.
//

import ObjectMapper

final class Author: Mappable {
    var name: String?
    var description: String?
    
    init() {}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        name <- map["nome"]
        description <- map["descricao"]
    }
}
