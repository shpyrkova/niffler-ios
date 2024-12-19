import XCTest

class SpendsPage: BasePage {
    func assertIsSpendsViewAppeared(file: StaticString = #filePath, line: UInt = #line) {
        XCTContext.runActivity(named: "Жду экран с тратами") { _ in
            waitSpendsScreen(file: file, line: line)
            XCTAssertGreaterThanOrEqual(app.scrollViews.switches.count, 1,
                                        "Не нашел трат в списке",
                                        file: file, line: line)
        }
    }
    
    @discardableResult
    func waitSpendsScreen(file: StaticString = #filePath, line: UInt = #line) -> Self {
        let isFound = app.staticTexts["Statistics"].waitForExistence(timeout: 10)
        XCTAssertTrue(isFound,
                      "Не дождались экрана со списком трат",
                      file: file, line: line)
        return self
    }
    
    func addSpent() {
        app.buttons["addSpendButton"].tap()
    }
    
    func goToProfilePage() {
        XCTContext.runActivity(named: "Перейти на экран профиля") { _ in
            app.images["ic_menu"].tap()
            app.staticTexts["Profile"].tap()
        }
    }
    
    func assertNewSpendIsShown(description: String, file: StaticString = #filePath, line: UInt = #line) {
        let isFound = app.firstMatch
            .scrollViews.firstMatch
            .staticTexts[description].firstMatch
            .waitForExistence(timeout: 1)
        
        XCTAssertTrue(isFound, file: file, line: line)
    }
    
    func assertIsEmptySpendsViewAppeared(file: StaticString = #filePath, line: UInt = #line) {
        XCTContext.runActivity(named: "Открыт пустой экран трат") { _ in
            let isFound = app.staticTexts["0 ₽"].waitForExistence(timeout: 5)
            XCTAssertTrue(isFound,
                          "Отсутствует текст с нулевыми тратами",
                          file: file, line: line)
        }
    }
}
