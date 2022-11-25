//
//  KeychainConstants.swift
//  KeychainWrapper
//
//  Created by Rodolfo Benjamin Alcantara Solorio on 10/17/19.
//  Copyright © 2019 AwesomeKeychain. All rights reserved.
//

/// Name of service
import Foundation

internal let service: String = "MySecretService"

/**
 Private enum to return possible errors
 */
internal enum Errors: Error {
    /// Error with the keychain creting and checking
    case creatingError
    /// Error for operation
    case operationError
}
