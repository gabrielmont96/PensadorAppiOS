//
//  ServiceAPI.swift
//  PensadorAppiOS
//
//  Created by Gabriel Silva on 21/03/19.
//  Copyright © 2019 Gabriel Silva. All rights reserved.
//

import Alamofire

final class ServiceAPI {
    static let sharedInstance = ServiceAPI()
    private init() {}
    
    func getCategories(success: @escaping (_ thinker: [Thinker]?) -> Void,
                         fail: @escaping (_ error: String?) -> Void) {
        
        let urlString = baseURL + "/categorias"
        
        guard let url = URL(string: urlString) else { return }
        
        
        Alamofire.request(url).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data,
                    let dataJson = try? JSONDecoder().decode([Thinker].self, from: data),
                    let statusCode = response.response?.statusCode,
                    statusCode == 200 {
                    success(dataJson)
                } else {
                    fail("Request Failed: \(urlString)")
                }
            case .failure:
                fail("Request Failed: \(urlString)")
            }
        }
}
    
    func getSearchResult(param: String, page: Int, success: @escaping (_ thinker: List) -> Void,
                       fail: @escaping (_ error: String?) -> Void) {
        
        let urlString = String(format: "%@/frases/%@/%@", baseURL, param, String(page))
        
        guard let url = URL(string: urlString) else { return }
        
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.data,
                    let dataJson = try? JSONDecoder().decode(List.self, from: data),
                    let statusCode = response.response?.statusCode,
                    statusCode == 200 {
                        success(dataJson)
                    } else {
                        fail("Request Failed: \(urlString)")
                }
                
            case .failure(let error):
                fail(error.localizedDescription)
            }
        }
    }
    
}
