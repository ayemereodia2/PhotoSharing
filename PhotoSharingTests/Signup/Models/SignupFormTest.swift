//
//  SignupFormTest.swift
//  PhotoSharingTests
//
//  Created by Ayemere  Odia  on 02/07/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import XCTest
@testable import PhotoSharing

class SignupFormTest: XCTestCase {
    var sut:SignupForm!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = SignupForm()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testSignupForm_whenFirstNameIsNotEmpty_shouldReturnTrue(){
        // Arrange
        //Act
        let isFirstNameValid = sut.isFirstNameValid(firstname:"Ayemere")
        //Assert
        XCTAssertTrue(isFirstNameValid, "The isFirstName() returns TRUE when firstname is empty, but it is returning FALSE")
    }
    
    func testSignupForm_whenFirstnameIsLessthan3digits_shouldReturnFalse(){
        // Arrange
        // Act
        let isFirstName = sut.isFirstNameValid(firstname: "Ay")
        // Assert
        XCTAssertFalse(isFirstName, "The isFirstNameValid() returns FALSE if the firstname is less-than 3 characters, but it is returning TRUE for characters less than 3")
    }
    
    func testSignupForm_whenFirstnameIsGreaterThan10digits_shouldReturnFalse(){
        // Arrange
        
        // Act
        let isFirstName = sut.isFirstNameValid(firstname: "Ayemeremere")
        // Assert
        XCTAssertFalse(isFirstName, "The isFirstNameValid() returns FALSE if the firstname is greater-than 10 characters, but it is returning TRUE for characters greater-than 10")
    }
    
    
    
    func testSignupForm_WhenFirstNameContainsSpecialCharacter_ShouldReturnFalse(){
        
        // Act
        let isFirstName = sut.isFirstNameValid(firstname: "Aye&")
        // Assert
        
        XCTAssertFalse(isFirstName,"The isFirstNameValid() returns FALSE if the firstname contains special characters, but it is returning TRUE")
    }
    
    func testSignupForm_WhenFirstNameContainsSpaces_ShouldReturnFalse(){
        // Act
        let isFirstName = sut.isFirstNameValid(firstname: "AyemereJames")
        
        // Assert
        XCTAssertFalse(isFirstName, "The isFirstNameValid() returns FALSE if the firstname contains spaces, but it is returning TRUE")
    }
    
    
    func testSignupForm_WhenPasswordIsValid_ShouldReturnTrue(){
        // Arrange
        
        // Act 
        let isPasswordValid = sut.isPasswordValid(password:"Des")
        // Assert
        
        XCTAssertTrue(isPasswordValid)
    }
    
    func testSignupForm_WhenPasswordIsLessThan8characters_ShouldReturnFalse(){
        
        // Act
        let isPasswordValid = sut.isPasswordValid(password: "treytrf")
        // Assert
        XCTAssertFalse(isPasswordValid, "The isPasswordValid() returns FALSE if password is less than 8 characters, but it is returning TRUE")
    }
    
    func testSignupForm_WhenPasswordNotContainsSpecChar_ShouldReturnFalse(){
        // Act 
        let isPasswordValid = sut.isPasswordValid(password: "Yyemere")
        
        // Assert
        XCTAssertFalse(isPasswordValid, "The isPasswordValid() returns FALSE if password does not contain special characters, but it is returning TRUE")
    }

    
    func testSignupForm_WhenPasswordContainsCorrectLetters_ShouldReturnTrue(){
        
        // Act
        let isValidPassword = sut.isPasswordValid(password: "@Ayemere5089")
        // Assert
        XCTAssertTrue(isValidPassword, "The isPasswordValid() returns TRUE if password contains correct characters, but it is returning FALSE")
    }
}
