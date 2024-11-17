//
//  String + Maskara.swift
//  LearningApp
//
//  Created by Lucas Pinto on 17/11/24.
//

extension String {
    
    func extractPhoneNumberDigits() -> String {
        return self.filter { $0.isNumber }
    }
}
