//
//  ServiceAPI.swift
//  PensadorAppiOS
//
//  Created by Gabriel Silva on 21/03/19.
//  Copyright © 2019 Gabriel Silva. All rights reserved.
//

import ObjectMapper
import Alamofire

final class ServiceAPI {
    static let sharedInstance = ServiceAPI()
    private init() {}
    
    func getCategories(success: @escaping (_ pensador: [Pensador]) -> Void,
                         fail: @escaping (_ error: String?) -> Void) {
        
        let urlString = String(format: "%@/categorias", baseURL)
        
        guard let url = URL(string: urlString) else { return }
        
        Network.request(url) { response in
            switch response.result {
            case .success:
                if let statusCode = response.response?.statusCode,
                    statusCode == 200,
                    let data = response.result.value as? [[String: Any]] {
                    
                    let retorno: [Pensador] = data.compactMap({ Pensador(JSON: $0) })
                    success(retorno)
                } else {
                    fail("Falha ao busca pedido")
                }
                
            case .failure(let error):
                fail(error.localizedDescription)
            }
        }
    }
}
