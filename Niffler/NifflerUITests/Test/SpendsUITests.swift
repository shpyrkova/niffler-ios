import XCTest

final class SpendsUITests: TestCase {
    
    func test_whenAddSpent_shouldShowSpendInList() {
        // Arrange
        let description = UUID.randomPart
        let amount = "250"
        let category = "Рыбалка"
        loginPage
            .input(login: "stage", password: "12345")
        // Act
        spendsPage
            .waitSpendsScreen()
            .addSpent()
        newSpendPage
            .inputSpent(amount: amount, description: description, category: category)
        // Assert
        spendsPage
            .assertNewSpendIsShown(description: description)
    }
    
    func test_checkEmptySpendsScreen() {
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
        let amount = "4360"
        let newCategory = "first category"
        let existingCategory = "Рыбалка"
        let password = "00000000"
        loginPage.pressCreateAccountButton()
        registerPage.register(username: username, password: password)
        loginPage.pressLoginButton()
        // Act
        spendsPage
            .waitSpendsScreen()
            .addSpent()
        newSpendPage
            .input(amount: amount)
            .input(description: spendDescription)
            .addNewCategoryIfAbsent(newCategory: newCategory, existingCategory: existingCategory)
            .pressAddSpend()
        spendsPage.goToProfilePage()
        profilePage.waitProfileScreen()
        // Assert
        profilePage.assertIsCategoryPresent(category: newCategory)
    }
    
    func test_deleteTheOneCategory() {
        // Arrange
        let username = TestUtils.generateUsername()
        let password = "00000000"
        let spendDescription = "first spend"
        let amount = "24"
        let category = "the one category"
        loginPage.pressCreateAccountButton()
        registerPage.register(username: username, password: password)
        loginPage.pressLoginButton()
        spendsPage
            .waitSpendsScreen()
            .addSpent()
        newSpendPage
            .input(amount: amount)
            .input(description: spendDescription)
            .addNew(category: category)
            .pressAddSpend()
        // Act
        spendsPage.goToProfilePage()
        profilePage
            .deleteCategory(category: category)
            .pressCloseButton()
        spendsPage.addSpent()
        // Assert
        newSpendPage.assertIsCategoriesListEmpty()
    }
    
}

extension UUID {
    static var randomPart: String {
        UUID().uuidString.components(separatedBy: "-").first!
    }
}

