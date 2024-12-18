import XCTest

final class SpendsUITests: TestCase {
    
    func test_whenAddSpent_shouldShowSpendInList() {
        launchAppWithoutLogin()
        
        // Arrange
        loginPage
            .input(login: "stage", password: "12345")
        
        // Act
        spendsPage
            .waitSpendsScreen()
            .addSpent()
        
        let description = UUID.randomPart
        newSpendPage
            .inputSpent(description: description)
        
        // Assert
        spendsPage
            .assertNewSpendIsShown(description: description)
    }
    
    func test_checkEmptySpendsScreen() {
        launchAppWithoutLogin()
        
        // Act
        loginPage
            .input(login: "empty", password: "00000000")
        
        // Assert
        spendsPage
            .assertIsEmptySpendsViewAppeared()
    }
    
    func test_createFirstSpendAndCategory() {
        // Arrange
        let username = TestUtils.generateUsername()
        let spendDescription = "first spend"
        let category = "first category"
        launchAppWithoutLogin()
        loginPage.pressCreateAccountButton()
        registerPage.register(username: username, password: "00000000")
        loginPage.pressLoginButton()
        // Act
        spendsPage
            .waitSpendsScreen()
            .addSpent()
        
        newSpendPage
            .inputAmount()
            .input(description: spendDescription)
            .addNewCategoryIfAbsent(category: category)
            .pressAddSpend()
        // Assert
        spendsPage.assertNewSpendIsShown(description: spendDescription)
    }
}

extension UUID {
    static var randomPart: String {
        UUID().uuidString.components(separatedBy: "-").first!
    }
}

