//
//  SignupWebServiceTest.swift
//  PhotoSharingTests
//
//  Created by Ayemere  Odia  on 04/07/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import XCTest
@testable import PhotoSharing

class SignupWebServiceTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSignWebservice_GivenSuccessfull_ReturnsSuccess(){
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        // define expected data
        let jsonString = "{\"status\":\"ok\"}"
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        // Act
        let sut = SignupWebService(urlString:PhotoConstants.signupUrl, urlSession: urlSession)
        
        let expectation = self.expectation(description: "Signup webservice response expectation")
        let signupFormModelRequest = SignupFormRequestModel(firstName: "Ayemere", lastName: 
        "Odia", email: "Davidodia4@gmail.com", password: "1234567890")
 
        // Arrange
         
        sut.signup(withform: signupFormModelRequest){(signupResponseModel, error) in
           
            // Assert
            XCTAssertEqual(signupResponseModel?.status, "ok")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout:5)
        
    }

    
    func testSignupWebService_WhenReceivedAdifferentJSONResponse_ReturnCorrectError(){
        
    }
}
