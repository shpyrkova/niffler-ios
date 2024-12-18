//
//  TestUtils.swift
//  Niffler
//
//  Created by surkova on 19.12.2024.
//

class TestUtils {
    
    static func generateUsername() -> String {
        let prefix = "user_"
        let suffixLength = 5
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let randomSuffix = String((0..<suffixLength).map { _ in characters.randomElement()! })
        return prefix + randomSuffix
    }
    
}
