import XCTest

class RegisterPage: BasePage {
    
    var registrationForm: XCUIElement {
        return app.otherElements.containing(.staticText, identifier: "Sign Up").firstMatch
    }
    
    @discardableResult
    func register(username: String, password: String) -> Self {
        XCTContext.runActivity(named: "Зарегистрироваться с данными \(username), \(password)") { _ in
            input(username: username)
            input(password: password)
            confirm(password: password)
            pressSignUpButton()
        }
        return self
    }
    
    private func input(username: String) {
        XCTContext.runActivity(named: "Ввести username \(username)") { _ in
            registrationForm.textFields["userNameTextField"].tap()
            registrationForm.textFields["userNameTextField"].typeText(username)
        }
    }
    
    private func input(password: String) {
        XCTContext.runActivity(named: "Ввести пароль \(password)") { _ in
            registrationForm.secureTextFields["passwordTextField"].tap()
            registrationForm.secureTextFields["passwordTextField"].typeText(password)
        }
    }
    
    private func confirm(password: String) {
        XCTContext.runActivity(named: "Подтвердить пароль \(password)") { _ in
            registrationForm.secureTextFields["confirmPasswordTextField"].tap()
            registrationForm.secureTextFields["confirmPasswordTextField"].typeText(password)
        }
    }
    
    private func pressSignUpButton() {
        XCTContext.runActivity(named: "Нажать Sign Up") { _ in
            registrationForm.buttons["Sign Up"].tap()
        }
    }
    
    func assertIsSuccessfulRegistrationPopupShown(file: StaticString = #filePath, line: UInt = #line) -> Self {
        XCTContext.runActivity(named: "Показано сообщение об успешной регистрации") { _ in
            let isFound = app.alerts["Congratulations!"].staticTexts[" You've registered!"].waitForExistence(timeout: 5)
            XCTAssertTrue(isFound,
                          "Сообщение об успешной регистрации не появилось",
                          file: file, line: line)
        }
        return self
    }
    
    func assertLoginScreenOpens(username: String, file: StaticString = #filePath, line: UInt = #line) {
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
    
}

