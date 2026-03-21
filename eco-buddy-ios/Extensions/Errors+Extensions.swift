//
//  Errors+Extensions.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 20/09/23.
//

import Foundation

struct APIError: Error {
    let endpoint: String
    let httpMethod: String
    let response: String
    let error: Error?
}

enum ServerMessage: String {
    case veriryEmail = "VERIFY_EMAIL"
    case userNotFound = "USER_NOT_FOUND"
    case unsupported
    
    var text: String {
        switch self {
        case .veriryEmail:
            return "Please verify your email"
        case .userNotFound:
            return "User is not found in the database"
        case .unsupported:
            return "Server-side error"
        }
    }
}

/// Application errors with detailed message
enum AppError: Error {
    case currentUserMissing
    case serverError(Error?)
    case serverMessage(ServerMessage)
    case apiError(APIError)
    case generalParsingError(String)
    case validationError(String)
    case firebaseLimitation(String)
    case invalidURL(String)
    case audioError(Error?)
    case notAvailable(String)
    case missingToken
    case clientSideError
    case unknown
    case coreDataError(Error?)
    case downloadError(Error)
    
    var message: String {
        switch self {
        case .currentUserMissing:
            return "Current logged user id is missing"
        case .serverError(let error):
            return error?.localizedDescription ?? "Unknown server error"
        case .serverMessage(let message):
            return message.text
        case .apiError(let error):
            var message = "Error occured during calling endpoind: \(error.httpMethod) \(error.endpoint)"
            message += "\n\(error.response)"
            return message
        case .firebaseLimitation(let message):
            return message
        case .invalidURL(let message):
            return message
        case .notAvailable(let message):
            return message
        case .validationError(let message):
            return message
        case .generalParsingError(let message):
            return message
        case .clientSideError:
            return "Client-side error"
        case .unknown:
            return "Unknown error"
        case .missingToken:
            return "The token was not retrieved from the backend"
        case .coreDataError(let error):
            return error?.localizedDescription ?? "Storage error"
        case .audioError(let error):
            return error?.localizedDescription ?? "Audio engine error"
        case .downloadError:
            return "Error downloading file"
        }
    }
}

extension AppError {
    var localizedDescription: String {
        return message
    }
}
