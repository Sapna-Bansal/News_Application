//
//  APIRouter.swift
//  Geidea
//
//  Created by Ivica Technologies on 09/12/20.
//  Copyright © 2020 ivicatechnologies. All rights reserved.
//

import Foundation
import Alamofire


struct API {
    
    struct Baseurlrequest {
        static let BasUrl = "http://newsapi.org/v2/everything?q=tesla&from=2021-01-06&sortBy=publishedAt&apiKey=7f9f9254959a4c8686b07a1b7df1e9e4"
    }
    
}


//enum HTTPHeaderField: String {
//    case authentication = "Authorization"
//    case XOcStoreId = "X-Oc-Store-Id"
//    case XOcImageDimension = "X-Oc-Image-Dimension"
//    case ContentType = "Content-Type"
//
//
//}
//
//enum ContentType: String {
//    case bearer = "Bearer d075c0ce7d7b170cdd55401430781b5d36912470"
//    case xocImage = "1"
//    case imageSize = "300*300"
//    case json = "application/json"
//
//}

enum APIRouter: URLRequestConvertible {
    case responce
    
    private var path: String {
        switch self {
        case .responce:
            return ""
        
        }
    }
    
    
    private var methods:HTTPMethod {
        switch self {
        case.responce:
            return.get
        default:
            break
        }
    }
    
    
    
    func asURLRequest() throws -> URLRequest {
        
        let URL = try API.Baseurlrequest.BasUrl.asURL()
        var urlRequest = URLRequest(url: URL.appendingPathComponent(path))
        urlRequest.httpMethod = methods.rawValue
        debugPrint("URL:----",urlRequest)
        // Common Headers
//        urlRequest.setValue(ContentType.bearer.rawValue, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
//
//        urlRequest.setValue(ContentType.xocImage.rawValue, forHTTPHeaderField: HTTPHeaderField.XOcStoreId.rawValue)
//
//        urlRequest.setValue(ContentType.imageSize.rawValue, forHTTPHeaderField: HTTPHeaderField.XOcImageDimension.rawValue)
//
//        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.ContentType.rawValue)
        
        // urlRequest.addValue("", forHTTPHeaderField: "")
        
        if let parameter = parameter(type: self){
            
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameter, options: [])
            } catch {
                //throw AFError.parameterEncoderFailed(reason: T##AFError.ParameterEncoderFailureReason)
                
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
    
}
