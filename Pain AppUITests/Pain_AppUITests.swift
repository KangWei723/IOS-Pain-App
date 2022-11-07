//
//  Pain_AppUITests.swift
//  Pain AppUITests
//
//  Created by Shrey Patel on 10/5/22.
//

import XCTest

final class Pain_AppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        let settingsApp = XCUIApplication(bundleIdentifier: "com.apple.Preferences")
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
            
        settingsApp.launch()
        settingsApp.tables.staticTexts["PASSWORDS"].tap()
            
        let passcodeInput = springboard.secureTextFields["Passcode field"]
        passcodeInput.tap()
        passcodeInput.typeText("abc\r") // it accepts anything in simulator
        settingsApp.tables.cells["PasswordOptionsCell"].buttons["chevron"].tap()
        if (settingsApp.switches["AutoFill Passwords"].value as? String) == "1" {
            settingsApp.switches["AutoFill Passwords"].tap()
        }

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViews() throws {
        let app = XCUIApplication()
        app.launch()
         
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText("patel.3705@osu.edu")
        app.keyboards.buttons["Hide keyboard"].tap()
        
        let password = app.secureTextFields["Password"]
        password.tap()
        password.typeText("test123456")
        if app.keyboards.buttons["Hide keyboard"].exists {
            app.keyboards.buttons["Hide keyboard"].tap()
        }
        
        let element = app.children(matching: .window).element(boundBy: 0)
            .children(matching: .other).element.children(matching: .other)
            .element.children(matching: .other).element.children(matching: .other)
            .element.children(matching: .other).element
        
        element.children(matching: .button)["Login"].tap()
        
        let profileButton = app.buttons["Profile"]
        profileButton.tap()
        app.buttons["Security"].tap()
        app.buttons["Back"].tap()
        
        app.buttons["Past\n Records"].tap()
        profileButton.tap()
        app.buttons["Back"].tap()
        
        app.buttons["Plus_Icon"].tap()
        
        element.children(matching: .button)["Back"].tap()
        profileButton.tap()
        let signOut = app.buttons["Sign\nOut"]
        signOut.tap()
    }
    
    func testSignUp() throws {
        let app = XCUIApplication()
        app.launch()
        
        app/*@START_MENU_TOKEN@*/.buttons["Signup"]/*[[".segmentedControls.buttons[\"Signup\"]",".buttons[\"Signup\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let fnameTextField = app.textFields["First Name"]
        fnameTextField.tap()
        fnameTextField.typeText("Brutus")
        if app.keyboards.buttons["Hide keyboard"].exists {
            app.keyboards.buttons["Hide keyboard"].tap()
        }
        
        let lnameTextField = app.textFields["Last Name"]
        lnameTextField.tap()
        lnameTextField.typeText("Buckeye")
        if app.keyboards.buttons["Hide keyboard"].exists {
            app.keyboards.buttons["Hide keyboard"].tap()
        }
        
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText("brutus.1@osu.edu")
        if app.keyboards.buttons["Hide keyboard"].exists {
            app.keyboards.buttons["Hide keyboard"].tap()
        }
        
        let password = app.secureTextFields["Password"]
        password.tap()
        password.typeText("test123456")
        if app.keyboards.buttons["Hide keyboard"].exists {
            app.keyboards.buttons["Hide keyboard"].tap()
        }
        
        let confirmPassword = app.secureTextFields["Confirm Password"]
        confirmPassword.tap()
        confirmPassword.typeText("test123456")
        if app.keyboards.buttons["Hide keyboard"].exists {
            app.keyboards.buttons["Hide keyboard"].tap()
        }
        
        app.buttons["Sign Up"].tap()
        
        let dob = app.textFields["Date of Birth"]
        dob.tap()
        dob.typeText("04/20/2001")
        if app.keyboards.buttons["Hide keyboard"].exists {
            app.keyboards.buttons["Hide keyboard"].tap()
        }
        
        let age = app.textFields["Age"]
        age.tap()
        age.typeText("21")
        if app.keyboards.buttons["Hide keyboard"].exists {
            app.keyboards.buttons["Hide keyboard"].tap()
        }
        
        let state = app.textFields["State"]
        state.tap()
        state.typeText("Ohio")
        if app.keyboards.buttons["Hide keyboard"].exists {
            app.keyboards.buttons["Hide keyboard"].tap()
        }
    
        let city = app.textFields["City"]
        city.tap()
        city.typeText("Columbus")
        if app.keyboards.buttons["Hide keyboard"].exists {
            app.keyboards.buttons["Hide keyboard"].tap()
        }
        
        let phoneNumber = app.textFields["Phone Number"]
        phoneNumber.tap()
        phoneNumber.typeText("+1 123 456 7890")
        if app.keyboards.buttons["Hide keyboard"].exists {
            app.keyboards.buttons["Hide keyboard"].tap()
        }
        
        let country = app.textFields["Country"]
        country.tap()
        country.typeText("US")
        if app.keyboards.buttons["Hide keyboard"].exists {
            app.keyboards.buttons["Hide keyboard"].tap()
        }
        
        app.buttons["Complete Registration"].tap()
        
        app.buttons["Profile"].tap()
        let signOut = app.buttons["Sign\nOut"]
        signOut.tap()
    }
    
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
