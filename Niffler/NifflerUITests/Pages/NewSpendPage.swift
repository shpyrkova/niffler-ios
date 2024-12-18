import XCTest

class NewSpendPage: BasePage {
    
    func inputSpent(description: String) {
        inputAmount()
            .addNewCategoryIfAbsent(category: "first category")
            .input(description: description)
        //        .swipeToAddSpendsButton()
            .pressAddSpend()
    }
    
    func inputAmount() -> Self {
        app.textFields["amountField"].typeText("14")
        return self
    }
    
    @discardableResult
    func selectCategory() -> Self {
        app.buttons["Select category"].tap() // TODO: Bug - Кнопка не отображается на UI, но тест проходит
        app.buttons["Рыбалка"].tap()
        return self
    }
    
    @discardableResult
    func addNew(category: String) -> Self {
        app.buttons["+ New category"].tap()
        app.textFields["Name"].typeText(category)
        app.alerts["Add category"].buttons["Add"].tap()
        return self
    }
    
    func addNewCategoryIfAbsent(category: String) -> Self {
        if app.buttons["+ New category"].exists {
            addNew(category: category)
        } else {
            selectCategory()
        }
        return self
    }
    
    func input(description: String) -> Self {
        app.textFields["descriptionField"].tap()
        app.textFields["descriptionField"].typeText(description)
        return self
    }
    
    //    func swipeToAddSpendsButton() -> Self {
    //        let screenCenter = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
    //        let screenTop = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.15))
    //        screenCenter.press(forDuration: 0.01, thenDragTo: screenTop)
    //        return self
    //    }
    
    func pressAddSpend() {
        app.buttons["Add"].tap()
    }
}
