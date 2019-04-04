//
//  Frase.swift
//  PensadorAppiOS
//
//  Created by Gabriel Silva on 22/03/19.
//  Copyright © 2019 Gabriel Silva. All rights reserved.
//

struct Phrase: Codable {
    var text: String?
    var sharing: String?
    var imageUrl: String?
    var author: Author?
    var favorite = false

    enum CodingKeys: String, CodingKey {
        case text = "texto"
        case sharing = "compartilhamentos"
        case imageUrl = "imagemUrl"
        case author = "autor"
    }
    
}
