//
//  Pensador.swift
//  PensadorAppiOS
//
//  Created by stag on 21/03/19.
//  Copyright © 2019 Gabriel Silva. All rights reserved.
//

import ObjectMapper

final class Pensador: Mappable {
    var nomePai: String?
    var listaCat: [ListaCat] = []
    var opened: Bool = false

    init() {}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        nomePai <- map["nomePai"]
        listaCat <- map["listaCat"]

    }
}
