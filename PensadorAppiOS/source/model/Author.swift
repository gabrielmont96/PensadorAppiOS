//
//  Author.swift
//  PensadorAppiOS
//
//  Created by Gabriel Silva on 25/03/19.
//  Copyright © 2019 Gabriel Silva. All rights reserved.
//

struct Author: Codable {
    var name: String?
    var description: String?

    enum CodingKeys: String, CodingKey {
        case name = "nome"
        case description = "descricao"
    }
}
