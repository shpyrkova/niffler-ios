import XCTest

final class RegisterUITests: TestCase {
    
    var username: String!
    var registrationForm: XCUIElement!
    
    // Arrange
    override func setUp() {
        super.setUp()
        username = TestUtils.generateUsername()
        launchAppWithoutLogin()
    }
    
    func test_registerSuccess() throws {
        // Act
        loginPage.pressCreateAccountButton()
        registerPage.register(username: username, password: "00000000")
        // Assert
        registerPage.assertIsSuccessfulRegistrationPopupShown()
        registerPage.assertLoginScreenOpens(username: username)
    }
    
}

