//
//  UserDefaultsHelper.swift
//  ITmentors
//
//  Created by Alexey Vadimovich on 23.11.2022.
//
import UIKit

final class UserDefaultsUserInfoManager{
    enum Keys: String{
        case isSignedInWithApple = "isSignedInWithApple"
        case isInfoFilled = "isInfoFilled"
    }


    static func writeString(value: Bool, forKey key: Keys){
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }

    static func getSignInInfo(forKey key: Keys) -> Bool{
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }
}
