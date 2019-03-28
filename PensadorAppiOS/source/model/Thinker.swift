//
//  Pensador.swift
//  PensadorAppiOS
//
//  Created by Gabriel Silva on 21/03/19.
//  Copyright © 2019 Gabriel Silva. All rights reserved.
//

struct Thinker: Codable {
    var name: String?
    var listCat: [ListCat] = []
    var opened: Bool = false

    enum CodingKeys: String, CodingKey {
        case name = "nomePai"
        case listCat = "listaCat"
    }
}
