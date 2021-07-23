//
//  UserHandler.swift
//  RxSwiftTest
//
//  Created by Ypodddd on 7/23/21.
//

import Alamofire
import CodableAlamofire

extension CustomAPI {
    public func getUser(input: String, completion: @escaping ([User]?) -> Void){
        let api_url = "https://randomuser.me/api/?results=" + input
        let request = Alamofire.request(api_url, method: .get)
        
        request.validate(statusCode: 200..<300).responseDecodableObject(keyPath: "results", decoder: JSONDecoder()) { (response: DataResponse<[User]>) in
            completion(response.result.value)
        }
        
        
    }
}
