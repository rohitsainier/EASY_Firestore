//
//  EASYTests.swift
//  EASYTests
//
//  Created by Rohit Saini on 06/01/19.
//  Copyright © 2019 Rohit Saini. All rights reserved.
//

import XCTest
@testable import EASY

class EASYTests: XCTestCase {
    
    //
    func test_Placeholder() {
        //Login
        let Login : LoginVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        let _ = Login.view
         XCTAssertEqual("Email", Login.emailTxt.placeholder!)
        
        
        //Sign Up
        let SignUp : Register = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "Register") as! Register
        let _ = SignUp.view
        XCTAssertEqual("Name", SignUp.nameTxt.placeholder!)
    }

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        test_Placeholder()
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
