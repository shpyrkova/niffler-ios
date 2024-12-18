import XCTest

final class RegisterUITests: TestCase {
    
    var username: String!
    var registrationForm: XCUIElement!
    
    // Arrange
    override func setUp() {
        super.setUp()
        username = generateUsername()
        launchAppWithoutLogin()
        registrationForm = app.otherElements.containing(.staticText, identifier: "Sign Up").firstMatch
    }
    
    func test_registerSuccess() throws {
        // Act
        pressCreateAccountButton()
        inputUsername(username)
        inputPassword("00000000")
        confirmPassword("00000000")
        pressSignUpButton()
        // Assert
        assertIsSuccessfulRegistrationPopupShown()
        assertLoginScreenOpens()
    }
    
    private func pressCreateAccountButton() {
        XCTContext.runActivity(named: "Нажать Create new account") { _ in
            app.staticTexts["Create new account"].tap()
        }
    }
    
    private func pressSignUpButton() {
        XCTContext.runActivity(named: "Нажать Sign Up") { _ in
            registrationForm.buttons["Sign Up"].tap()
        }
    }
    
    private func inputUsername(_ username: String) {
        XCTContext.runActivity(named: "Ввести username \(username)") { _ in
            registrationForm.textFields["userNameTextField"].tap()
            registrationForm.textFields["userNameTextField"].typeText(username)
        }
    }
    
    private func inputPassword(_ password: String) {
        XCTContext.runActivity(named: "Ввести пароль \(password)") { _ in
            registrationForm.secureTextFields["passwordTextField"].tap()
            registrationForm.secureTextFields["passwordTextField"].typeText(password)
        }
    }
    
    private func confirmPassword(_ password: String) {
        XCTContext.runActivity(named: "Подтвердить пароль \(password)") { _ in
            registrationForm.secureTextFields["confirmPasswordTextField"].tap()
            registrationForm.secureTextFields["confirmPasswordTextField"].typeText(password)
        }
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
        XCTContext.runActivity(named: "На экране логина заполнены логин и пароль") { _ in
            let isFound = app.textFields[username].waitForExistence(timeout: 5)
            XCTAssertTrue(isFound,
                          "На экране логина должен быть username \(username)",
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

