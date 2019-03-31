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
    
    func getCategories(success: @escaping (_ thinker: [Thinker]) -> Void,
                         fail: @escaping (_ error: String?) -> Void) {
        
        let urlString = String(format: "%@/categorias", baseURL)
        
        guard let url = URL(string: urlString) else { return }
        
        Network.request(url) { response in
            switch response.result {
            case .success:
                if let statusCode = response.response?.statusCode,
                    statusCode == 200,
                    let data = response.result.value as? [[String: Any]] {
                    
                    let dataJson: [Thinker] = data.compactMap({ Thinker(JSON: $0) })
                    success(dataJson)
                } else {
                    fail("Request Failed: \(urlString)")
                }
                
            case .failure(let error):
                fail(error.localizedDescription)
            }
        }
    }
    
    func getCategoryResult(param: String, page: Int, success: @escaping (_ thinker: List) -> Void,
                       fail: @escaping (_ error: String?) -> Void) {
        let urlString = String(format: "%@/frases/%@/%@", baseURL, param, String(page))
        
        guard let url = URL(string: urlString) else { return }
        
        Network.request(url) { response in
            switch response.result {
            case .success:
                if let statusCode = response.response?.statusCode,
                    statusCode == 200,
                    let data = response.result.value as? [String: Any] {
                    
                    if let dataJson = List(JSON: data) {
                        success(dataJson)
                    }
                } else {
                    fail("Request Failed: \(urlString)")
                }
                
            case .failure(let error):
                fail(error.localizedDescription)
            }
        }
    }
    
    func getSearchResult(param: String, page: Int, success: @escaping (_ thinker: List) -> Void,
                         fail: @escaping (_ error: String?) -> Void) {
        let paramFormatted = param.replacingOccurrences(of: " ", with: "%20")
        let urlString = String(format: "%@/frases/buscar/%@/%@", baseURL, paramFormatted, String(page))
        
        guard let url = URL(string: urlString) else { return }
        
        Network.request(url) { response in
            switch response.result {
            case .success:
                if let statusCode = response.response?.statusCode,
                    statusCode == 200,
                    let data = response.result.value as? [String: Any] {
                    
                    if let dataJson = List(JSON: data) {
                        success(dataJson)
                    }
                } else {
                    fail("Request Failed: \(urlString)")
                }
                
            case .failure(let error):
                fail(error.localizedDescription)
            }
        }
    }
    
}
