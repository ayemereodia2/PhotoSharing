//
//  SignupWebService.swift
//  PhotoSharing
//
//  Created by Ayemere  Odia  on 04/07/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import Foundation

class SignupWebService {
    
    private let urlSession:URLSession
    private let urlString:String
    
    init(urlString:String, urlSession:URLSession = .shared) {
        self.urlString = urlString
        self.urlSession = urlSession
    }
    
    func signup(withform: SignupFormRequestModel, completionHandler: @escaping (SignupResponseModel?, SignupErrors?)->Void){
        
        guard let url = URL(string: urlString) else {
            completionHandler(nil,SignupErrors.invalidURLStringError)
            return 
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(withform)
        
        //Sending the httprequest
        let dataTask = self.urlSession.dataTask(with: request) { (data, response, error) in
            
            if let requestError = error {
                completionHandler(nil, SignupErrors.failedRequest(description:requestError.localizedDescription))
                return
            }
            
            if let data = data, let signupResponse = try? JSONDecoder().decode(SignupResponseModel.self, from: data){
                completionHandler(signupResponse, nil)
            }else {
                completionHandler(nil,SignupErrors.responseModelParsingError)
            }
        }
        
        dataTask.resume()
    }
}
