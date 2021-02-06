//
//  ApiClient.swift
//  Geidea
//
//  Created by Ivica Technologies on 09/12/20.
//  Copyright © 2020 ivicatechnologies. All rights reserved.
//

import Foundation
import Alamofire


class ApiClient{
    @discardableResult
    private static func dataRequst<T:Decodable>(roughter:APIRouter,decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T,AFError>)-> Void ) -> DataRequest {
        return AF.request(roughter).responseDecodable (decoder: decoder){ (response: DataResponse<T,AFError>) in
            completion(response.result)
            
        }
    }
    
    static func loder<T:Decodable>(roughter:APIRouter,completion:@escaping(T) -> Void){
        let jsondecoder = JSONDecoder()
        dataRequst(roughter: roughter, decoder: jsondecoder) { (result: Result<T,AFError>) in
            switch result {
            case.success(let t):
                completion(t)
                
            case.failure(let error):
                print("ERROR CODE:",error.localizedDescription)
                
            }
        }
    }
}
