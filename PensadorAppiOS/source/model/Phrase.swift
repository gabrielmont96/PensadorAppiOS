//
//  Frase.swift
//  PensadorAppiOS
//
//  Created by Gabriel Silva on 22/03/19.
//  Copyright © 2019 Gabriel Silva. All rights reserved.
//

import ObjectMapper

final class Phrase: Mappable {
    var text: String?
    var sharing: String?
    var imageUrl: String?
    var author: Author?
    
    init() {}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        text <- map["texto"]
        sharing <- map["compartilhamentos"]
        imageUrl <- map["imagemUrl"]
        author <- map["autor"]
    }
}
