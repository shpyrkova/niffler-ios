import XCTest

class ProfilePage: BasePage {
    
    func deleteCategory(category: String) {
        XCTContext.runActivity(named: "Удалить категорию \(category)") { _ in
            app.collectionViews.staticTexts[category].swipeLeft()
            app.collectionViews.buttons["Delete"].tap()
        }
    }
    
    func pressCloseButton() {
        XCTContext.runActivity(named: "Нажать на кнопку закрытия экрана профиля") { _ in
            app.buttons["Close"].tap()
            
        }
    }
    
    func assertIsCategoryPresent(category: String, file: StaticString = #filePath, line: UInt = #line) {
        XCTContext.runActivity(named: "На экране профиля присутствует категория \(category)") { _ in
            let isFound = app.collectionViews.staticTexts[category]
                .waitForExistence(timeout: 5)
            
            XCTAssertTrue(isFound,
                          "В профиле отсутствует категория \(category)",
                          file: file, line: line)
        }
    }
    
    @discardableResult
    func waitProfileScreen(file: StaticString = #filePath, line: UInt = #line) -> Self {
        XCTContext.runActivity(named: "Подождать загрузки экрана профиля") { _ in
            let isFound = app.staticTexts["USER INFO"].waitForExistence(timeout: 5)
            XCTAssertTrue(isFound,
                          "Экран профиля не открылся",
                          file: file, line: line)
            return self
        }
    }
    
}



