import XCTest

final class RegisterUITests: TestCase {
    
    var username: String!
    
    override func setUp() {
        super.setUp()
        username = generateUsername()
    }
    
    func test_registerSuccess() throws {
        // Arrange
        let app = XCUIApplication()
        app.launch()
            
        // Act
        app.staticTexts["Create new account"].tap()
        let registrationForm = app.otherElements.containing(.staticText, identifier: "Sign Up").firstMatch
        let userNameTextField = registrationForm.textFields["userNameTextField"]
        userNameTextField.tap()
        userNameTextField.typeText(username)
        registrationForm.secureTextFields["passwordTextField"].tap()
        registrationForm.secureTextFields["passwordTextField"].typeText("00000000")
        registrationForm.secureTextFields["confirmPasswordTextField"].tap()
        registrationForm.secureTextFields["confirmPasswordTextField"].typeText("00000000")
        registrationForm.buttons["Sign Up"].tap();
        
        // Assert
        assertIsSuccessfulRegistrationPopupShown()
        assertLoginScreenOpens()

    }
    
    func assertIsSuccessfulRegistrationPopupShown(file: StaticString = #filePath, line: UInt = #line) {
        XCTContext.runActivity(named: "Показано сообщение об успешной регистрации") { _ in
            let isFound = app.alerts["Congratulations!"].staticTexts[" You've registered!"].waitForExistence(timeout: 5)
            XCTAssertTrue(isFound,
                          "Сообщение об успешной регистрации не появилось",
                          file: file, line: line)
        }
    }
    
    func assertLoginScreenOpens(file: StaticString = #filePath, line: UInt = #line) {
        app.alerts["Congratulations!"].buttons["Log in"].tap()
        XCTContext.runActivity(named: "По нажатию Log in в попапе открывается экран логина") { _ in
            let isFound = app.staticTexts["Log in"].waitForExistence(timeout: 5)
            XCTAssertTrue(isFound,
                          "Экран логина не открыт",
                          file: file, line: line)
        }
        XCTContext.runActivity(named: "На экране логина поля заполнены данными, указанными при регистрации") { _ in
            let isFound = app.textFields[username].waitForExistence(timeout: 5)
            XCTAssertTrue(isFound,
                          "На экране логина логин не заполнен данными регистрации",
                          file: file, line: line)
            if let value = app.secureTextFields["passwordTextField"].value as? String {
                XCTAssertFalse(value.isEmpty, "Поле пароля пустое", file: file, line: line)
                }
        }
    }
    
    func generateUsername() -> String {
        let prefix = "user_"
        let suffixLength = 5
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let randomSuffix = String((0..<suffixLength).map { _ in characters.randomElement()! })
        return prefix + randomSuffix
    }
     
}

