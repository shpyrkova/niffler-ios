import XCTest

class NewSpendPage: BasePage {
    
    func inputSpent(amount: String, description: String, category: String) {
        XCTContext.runActivity(named: "Создать новую трату") { _ in
            input(amount: amount)
                .select(category: category)
                .input(description: description)
            //        .swipeToAddSpendsButton()
                .pressAddSpend()
        }
    }
    
    func input(amount: String) -> Self {
        XCTContext.runActivity(named: "Ввести сумму траты \(amount)") { _ in
            app.textFields["amountField"].typeText(amount)
            return self
        }
    }
    
    @discardableResult
    func select(category: String) -> Self {
        XCTContext.runActivity(named: "Выбрать категорию \(category)") { _ in
            app.buttons["Select category"].tap() // TODO: Bug - Кнопка не отображается на UI, но тест проходит
            app.buttons[category].tap()
            return self
        }
    }
    
    @discardableResult
    func addNew(category: String) -> Self {
        XCTContext.runActivity(named: "Добавить новую категорию \(category)") { _ in
            app.buttons["+ New category"].tap()
            app.textFields["Name"].typeText(category)
            app.alerts["Add category"].buttons["Add"].tap()
            return self
        }
    }
    
    func addNewCategoryIfAbsent(newCategory: String, existingCategory: String) -> Self {
        XCTContext.runActivity(named: "Выбрать категорию \(newCategory) или добавить новую, если категорий нет") { _ in
            if app.buttons["+ New category"].exists {
                addNew(category: newCategory)
            } else {
                select(category: existingCategory)
            }
            return self
        }
    }
    
    func input(description: String) -> Self {
        XCTContext.runActivity(named: "Ввести описание траты \(description)") { _ in
            app.textFields["descriptionField"].tap()
            app.textFields["descriptionField"].typeText(description)
            return self
        }
    }
    
    //    func swipeToAddSpendsButton() -> Self {
    //        let screenCenter = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
    //        let screenTop = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.15))
    //        screenCenter.press(forDuration: 0.01, thenDragTo: screenTop)
    //        return self
    //    }
    
    func pressAddSpend() {
        XCTContext.runActivity(named: "Нажать на кнопку создания траты") { _ in
            app.buttons["Add"].tap()
        }
    }
    
    func assertIsCategoriesListEmpty(file: StaticString = #filePath, line: UInt = #line) {
        XCTContext.runActivity(named: "Присутствует кнопка New category, категорий нет") { _ in
            let newCategoryButtonIsPresent = app.buttons["+ New category"].waitForExistence(timeout: 3)
            XCTAssertTrue(newCategoryButtonIsPresent,
                          "Отсутствует кнопка New category",
                          file: file, line: line)
            app.buttons["+ New category"].tap()
            let newCategoryAlertIsPresent = app.alerts["Add category"].waitForExistence(timeout: 5)
            XCTAssertTrue(newCategoryAlertIsPresent,
                          "Отсутствует Alert Add category",
                          file: file, line: line)
        }
    }
    
}
