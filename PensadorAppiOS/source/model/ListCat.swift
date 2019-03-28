//
//  ListaCat.swift
//  PensadorAppiOS
//
//  Created by Gabriel Silva on 21/03/19.
//  Copyright © 2019 Gabriel Silva. All rights reserved.
//

struct ListCat: Codable {
    var name: String?
    var urlAPI: String?
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "nome"
        case urlAPI = "url"
    }
}
