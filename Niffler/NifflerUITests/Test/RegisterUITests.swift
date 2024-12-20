import XCTest

final class RegisterUITests: TestCase {
    
    func test_registerSuccess() throws {
        // Arrange
        let username = TestUtils.generateUsername()
        let password = "00000000"
        // Act
        loginPage.pressCreateAccountButton()
        registerPage.register(username: username, password: password)
        // Assert
        registerPage
            .assertIsSuccessfulRegistrationPopupShown()
            .assertLoginScreenOpens(username: username)
    }
    
}

