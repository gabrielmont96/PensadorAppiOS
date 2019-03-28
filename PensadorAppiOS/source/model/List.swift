//
//  List.swift
//  PensadorAppiOS
//
//  Created by Gabriel Silva on 25/03/19.
//  Copyright © 2019 Gabriel Silva. All rights reserved.
//

struct List: Codable {
    var list: [Phrase] = []

    enum CodingKeys: String, CodingKey {
        case list = "lista"
    }
}
