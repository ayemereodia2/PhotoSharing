//
//  SignupFormRequestModel.swift
//  PhotoSharing
//
//  Created by Ayemere  Odia  on 04/07/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import Foundation
struct SignupFormRequestModel: Encodable {
    let firstName:String
    let lastName:String
    let email:String
    let password:String
}
