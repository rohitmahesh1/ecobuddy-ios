//
//  CrashlyticsExtensions.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 20/09/23.
//

import FirebaseCrashlytics

extension FirebaseCrashlytics.Crashlytics {
    static func logNonFatal(
        _ message: String,
        code: Int = 0,
        domain: String = "ios.error",
        function: String = #function,
        file: String = #file,
        line: Int = #line) {

        let functionKey = "\(domain).function"
        let fileKey = "\(domain).file"
        let lineKey = "\(domain).line"

        let error = NSError(domain: domain, code: code, userInfo: [
            NSLocalizedDescriptionKey: message,
            functionKey: function,
            fileKey: file,
            lineKey: line
        ])

        Crashlytics.crashlytics().record(error: error)
    }
    
    static func logNonFatal(
        with error: Error,
        function: String = #function,
        file: String = #file,
        line: Int = #line) {
        let message: String
        if let appError = error as? AppError {
            message = appError.message
        } else {
            message = error.localizedDescription
        }
        let nsError = error as NSError
        logNonFatal(
            message,
            code: nsError.code,
            domain: nsError.domain,
            function: function,
            file: file,
            line: line
        )
    }
}
