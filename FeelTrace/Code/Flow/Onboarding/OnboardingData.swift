//
//  OnboardingData.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 5/3/2024.
//

import Foundation

struct OnboardingData: Codable {
    var imageName: String
    var categories: [Category]
    var name: String
    var age: String
}


class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let userDefaults = UserDefaults.standard
    private let onboardingDataKey = "OnboardingData"
    
    
    func saveOnboardingData(data: OnboardingData) {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(data) {
            userDefaults.set(encodedData, forKey: onboardingDataKey)
        }
    }
    
    func getOnboardingData() -> OnboardingData {
        guard let savedData = userDefaults.data(forKey: onboardingDataKey) else {
            return getDefaultOnboardingData()
        }
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(OnboardingData.self, from: savedData)
            return decodedData
        } catch {
            return getDefaultOnboardingData()
        }
    }

    private func getDefaultOnboardingData() -> OnboardingData {
        return OnboardingData(imageName: "profile1", categories: [], name: "", age: "")
    }

    
    func clearOnboardingData() {
        userDefaults.removeObject(forKey: onboardingDataKey)
    }
}

