//
//  Validators.swift
//  rplusapp
//
//  Created by Josué López on 11/9/20.
//  Copyright © 2020 Josué López. All rights reserved.
//

import Foundation

class ValidationError: Error {
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
}

protocol ValidatorConvertible {
    func validated(_ value: String) throws -> String
}

enum ValidatorType {
    case email
    case password
    case username
    case userrplusapp
    case serialNumber
    case requiredField(field: String, min: Int)
    case age
}

enum VaildatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .email: return EmailValidator()
        case .password: return PasswordValidator()
        case .username: return UserNameValidator()
        case .userrplusapp: return UserrplusappValidator()
        case .serialNumber: return SerialNumberValidator()
        case .requiredField(let fieldName, let minCount): return RequiredFieldValidator(fieldName, min: minCount)
        case .age: return AgeValidator()
        }
    }
}

//"J3-123A" i.e
struct SerialNumberValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        do {
            if try NSRegularExpression(pattern: "^[A-Z]{1}[0-9]{1}[-]{1}[0-9]{3}[A-Z]$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid Serial Number Format")
            }
        } catch {
            throw ValidationError("Invalid Serial Number Format")
        }
        return value
    }
}

class AgeValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else {throw ValidationError("Age is required")}
        guard let age = Int(value) else {throw ValidationError("Age must be a number!")}
        guard value.count < 3 else {throw ValidationError("Invalid age number!")}
        guard age >= 18 else {throw ValidationError("You have to be over 18 years old to user our app :)")}
        return value
    }
}

struct RequiredFieldValidator: ValidatorConvertible {
    private let fieldName: String
    private let minCount: Int
    
    init(_ field: String, min: Int) {
        fieldName = field
        minCount = min
    }
    
    func validated(_ value: String) throws -> String {
        guard !value.isEmpty else {
            throw ValidationError("\(Constants.Validations.requiredFieldText) " + fieldName)
        }
        guard value.count >= minCount else {
            throw ValidationError("\(fieldName) \(Constants.Validations.requiredMinField) ")
        }
        return value
    }
}

struct UserrplusappValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count >= 9 else {
            throw ValidationError("\(Constants.Validations.userrplusappMaxError)" )
        }
        guard value.count < 15 else {
            throw ValidationError("\(Constants.Validations.userrplusappMinError)" )
        }
        
        do {
            if try NSRegularExpression(pattern: "^[A-Za-z0-9_-]*$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("\(Constants.Validations.userrplusappSpaceError)")
            }
        } catch {
            throw ValidationError("\(Constants.Validations.userrplusappSpaceError)")
        }
        return value
    }
}

struct UserNameValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count >= 3 else {
            throw ValidationError("Username must contain more than three characters" )
        }
        guard value.count < 18 else {
            throw ValidationError("Username shoudn't conain more than 18 characters" )
        }
        
        do {
            if try NSRegularExpression(pattern: "^[a-z]{1,18}$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid username, username should not contain whitespaces, numbers or special characters")
            }
        } catch {
            throw ValidationError("Invalid username, username should not contain whitespaces,  or special characters")
        }
        return value
    }
}

struct PasswordValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value != "" else {throw ValidationError("\(Constants.Validations.passwordRequired)")}
        guard value.count >= 4 else { throw ValidationError("\(Constants.Validations.passwordMaxError)") }
        
        do {
            if try NSRegularExpression(pattern: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{4,}$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("\(Constants.Validations.passwordSpaceError)")
            }
        } catch {
            throw ValidationError("\(Constants.Validations.passwordSpaceError)")
        }
        return value
    }
}

struct EmailValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        do {
            if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("\(Constants.Validations.emailInvalidError)")
            }
        } catch {
            throw ValidationError("\(Constants.Validations.emailInvalidError)")
        }
        return value
    }
}
