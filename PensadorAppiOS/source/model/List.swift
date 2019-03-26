//
//  List.swift
//  PensadorAppiOS
//
//  Created by Gabriel Silva on 25/03/19.
//  Copyright © 2019 Gabriel Silva. All rights reserved.
//

import ObjectMapper

final class List: Mappable {
    
    var list: [Phrase] = []
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        list <- map["lista"]
    }
}
