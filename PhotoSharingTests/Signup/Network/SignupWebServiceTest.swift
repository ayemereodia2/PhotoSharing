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

    var sut:SignupWebService!
    var signupFormModelRequest:SignupFormRequestModel!
    
    override func setUp() {
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        // Put setup code here. This method is called before the invocation of each test method in the class.
         sut = SignupWebService(urlString:PhotoConstants.signupUrl, urlSession: urlSession)
         signupFormModelRequest = SignupFormRequestModel(firstName: "Ayemere", lastName: 
                                    "Odia", email: "Davidodia4@gmail.com", password: "1234567890")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        signupFormModelRequest = nil
        MockURLProtocol.stubResponseData = nil
    }

    func testSignWebservice_GivenSuccessfull_ReturnsSuccess(){
       
        // define expected data
        let jsonString = "{\"status\":\"ok\"}"
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        // Act
    
        
        let expectation = self.expectation(description: "Signup webservice response expectation")
 
        // Arrange
         
        sut.signup(withform: signupFormModelRequest){(signupResponseModel, error) in
           
            // Assert
            XCTAssertEqual(signupResponseModel?.status, "ok")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout:5)
        
    }

    
    func testSignupWebService_WhenReceivedWrongJSONResponse_ReturnCorrectJSONError(){
        
               // define expected data
               let jsonString = "{\"path\":\"/users\", \"error\":\"Internal Server Error\"}"
               MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
               
               // Act
              
               let expectation = self.expectation(description: "Signup webservice response expectation for response with JSON of different structure")
              
        
               // Arrange
                
               sut.signup(withform: signupFormModelRequest){(signupResponseModel, error) in
                  
                   // Assert
                XCTAssertNil(signupResponseModel, "The response model for the unknown JSON response should have been nil")
                XCTAssertEqual(error, SignupErrors.responseModelParsingError, "signup() did not return expected error") 
                   expectation.fulfill()
               }
               
               self.wait(for: [expectation], timeout:5)
    }
    
    
    func testSignWebService_WhenUrlStringCouldNotBeformed_ReturnInvalidUrlError(){
       
        // Arrange
        sut = SignupWebService(urlString:"")
        let expectation = self.expectation(description: "empty url expectation")
        // Act
        sut.signup(withform: signupFormModelRequest){(signupResponseModel, error) in 
            
            // Assert
            XCTAssertNil(signupResponseModel, "When invalid urlStringError occurs, this signupResponseModel must be nil")
            XCTAssertEqual(error, SignupErrors.invalidURLStringError,"For an invalid url string, this Error is an invalidURL Error, you have returned a different error type")
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 2)
    }
    
    func testSignupWebService_WhenURLRequestFails_ReturnErrorDescription(){
        
        // Arrange
        
        let expectation = self.expectation(description: "A failed request expecation")
        let errorDescription = "a localized error descritpion"
        MockURLProtocol.error = SignupErrors.failedRequest(description:errorDescription)
        // Act 
        sut.signup(withform: signupFormModelRequest){(signupResponseModel, error) in 
            
            // Assert
         XCTAssertEqual(error, SignupErrors.failedRequest(description:errorDescription))
         XCTAssertEqual(error?.localizedDescription, errorDescription)
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 2)

    }
    
}
