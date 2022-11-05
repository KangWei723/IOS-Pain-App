////
////  LoginControllerTests.swift
////  Pain AppTests
////
////  Created by Shrey Patel on 11/3/22.
////
//
//import XCTest
//import Amplify
//import AmplifyPlugins
//import SwiftUI
//import Combine
//@testable import Pain_App
//
//final class LoginControllerTests: XCTestCase {
//
//    var mainViewController: MainViewController!
//    var loginController: LoginController!
//    var cancellable = Set<AnyCancellable>()
//
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//        try super.setUpWithError()
//        self.mainViewController = MainViewController()
//        self.loginController = LoginController(mainView: mainViewController)
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        let e = XCTestExpectation(description: #function)
//
//        self.loginController.signOutLocally()
//            .sink {
//                if case .failure(let error) = $0 {
//                    print(error)
//                    XCTFail("Errored when it should complete")
////                    e.fulfill()
//                }
//            } receiveValue: { value in
//                XCTAssertTrue(value)
//                self.loginController.$loginState
//                    .dropFirst()
//                    .sink { value in
//                        XCTAssertEqual(value, .login)
//                        e.fulfill()
//                    }.store(in: &self.cancellable)
//            }.store(in: &self.cancellable)
//
////        self.loginController.$loginState
////            .dropFirst()
////            .sink { value in
////                XCTAssertTrue(value == .login)
////               e.fulfill()
////            }.store(in: &self.cancellable)
//
//        wait(for: [e], timeout: 3)
//        loginController = nil
//        mainViewController = nil
//    }
//
//    func testLoginValid() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//        let email: String = "patel.3705@osu.edu"
//        let password: String = "test123456"
//
//        let expect = XCTestExpectation(description: #function)
//
//        XCTAssertTrue(self.loginController.loginState == .login)
//
//        self.loginController.signIn(email: email, password: password)
//            .sink {
//                if case .failure(let error) = $0 {
//                    XCTFail("Errored when it should complete: \(error)")
//                    expect.fulfill()
//                }
//            } receiveValue: { value in
//                XCTAssertTrue(value)
//                self.loginController.$loginState
//                    .dropFirst()
//                    .sink { value in
//                        XCTAssertEqual(value, .session())
//                        expect.fulfill()
//                    }.store(in: &self.cancellable)
//            }.store(in: &self.cancellable)
//
//        wait(for: [expect], timeout: 3)
//    }
//
//    func testLoginInvalid() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//        let email: String = "patel@osu.edu"
//        let password: String = "test123456"
//        let errorMsg =
//        """
//        AuthError: User does not exist.
//        Recovery suggestion: Make sure that the user is present in the backend
//        Caused by:
//        userNotFound
//        """
//
//        XCTAssertTrue(self.loginController.loginState == .login)
//
//        self.loginController.signIn(email: email, password: password)
//            .sink { completion in
//                switch completion {
//                case .failure(let err as AuthError):
//                    XCTAssertEqual(err.debugDescription, errorMsg)
//                    XCTAssertEqual(self.loginController.loginState, .login)
//                default:
//                    XCTFail("Completed when it should fail")
//                }
//            } receiveValue: { _ in
//                XCTFail("Completed when it should fail")
//            }.store(in: &self.cancellable)
//    }
//
////    func testPerformanceExample() throws {
////        // This is an example of a performance test case.
////        self.measure {
////            // Put the code you want to measure the time of here.
////        }
////    }
//
//}
