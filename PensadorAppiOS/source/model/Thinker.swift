//
//  Pensador.swift
//  PensadorAppiOS
//
//  Created by Gabriel Silva on 21/03/19.
//  Copyright © 2019 Gabriel Silva. All rights reserved.
//

import ObjectMapper

final class Thinker: Mappable {
    var name: String?
    var listCat: [ListCat] = []
    var opened: Bool = false

    init() {}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        name <- map["nomePai"]
        listCat <- map["listaCat"]

    }
}
