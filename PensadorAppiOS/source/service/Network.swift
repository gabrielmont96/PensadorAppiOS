//
//  AppDelegate.swift
//  PensadorAppiOS
//
//  Created by Gabriel Silva on 21/03/19.
//  Copyright © 2019 Gabriel Silva. All rights reserved.
//

import Foundation
import Alamofire

final class Network {
    
    enum NetworkMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    // MARK: public
    @discardableResult
    class func request(_ url: URL,
                       method: NetworkMethod = .get,
                       parameters: [String: Any]? = nil,
                       headers: [String: String]? = nil,
                       encoding: ParameterEncoding = JSONEncoding.default,
                       log: Bool = true,
                       completion: @escaping (DataResponse<Any>) -> Void) -> URLSessionTask? {
        let alamofireMethod = HTTPMethod(rawValue: method.rawValue) ?? .get
        
        var finalHeaders = defaultHeaders()
        if let headers = headers {
            
        }
        
        /// configura o timeout da requisicao
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        
        let request = manager.request(url,
                                      method: alamofireMethod,
                                      parameters: parameters,
                                      encoding: encoding,
                                      headers: finalHeaders)
            .responseJSON { response in
                
                if log {
                    logAlamofireRequest(response: response)
                }
                
                
                let data : [String:Any] = [
                    "url": url,
                    "method": method.rawValue,
                    "body": parameters,
                    "headers": headers,
                    "response": response.result.value
                ]
                
                completion(response)
        }
        
        return request.task
    }
    
    // MARK: helpers
    private class func defaultHeaders() -> [String: String] {
        var headers: [String: String] = [:]
        return headers
    }
    
    private class func logAlamofireRequest(response: DataResponse<Any>) {
        
        //MARK: - LOGS
        func log(_ str: Any...){
            print("\n\n===> CEADB Network: \(str[0])"); if str.count > 1 { print(str[1]) }
        }
        
        guard let request = response.request else { return }
        guard let url = request.url else { return }
        guard let httpMethod = request.httpMethod else { return }
        
        log("->REQUEST(\(httpMethod))\n\(url)\n")
        
        if let requestHeaders = request.allHTTPHeaderFields {

        }
        
        if let httpBody = request.httpBody {
            if let jsonBody = try? JSONSerialization.jsonObject(with: httpBody) {
                
                if let array = jsonBody as? [[String:Any]] {
                   
                }
                else if let object = jsonBody as? [String:Any] {
                    
                }else{
                    log("->BODY\n\n\(jsonBody)\n")
                }
                
            }
        }
        
        let statusCode = response.response?.statusCode ?? 0
        
        let statusCodeString = (statusCode != 0) ? "(\(statusCode))" : ""
        
        
        if let array = response.result.value as? [[String:Any]] {
            
        }
        else if let object = response.result.value as? [String:Any] {
            
        }
        else{
            log("->RESPONSE(Any)" + statusCodeString + "\n\n\(response.description)\n\n")
        }
        
    }
}





