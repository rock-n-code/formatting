//
//  Command.swift
//  FormattingCore
//
//  Created by Javier Cicchelli on 27/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import Foundation
import CoreSwift

struct Command {
    
    // MARK: Properties
    
    private let process = Process()
    private let pipe = Pipe()
    
}

// MARK: - Runnable

extension Command: Runnable {
    
    @discardableResult
    func callAsFunction(
        pathToCommand: String,
        arguments: [String]? = nil
    ) throws -> Data? {
        guard pathToCommand.isNotEmpty else {
            throw CommandError.pathToCommandNotDefined
        }
        
        process.executableURL = .init(fileURLWithPath: pathToCommand)
        process.arguments = arguments
        process.standardOutput = pipe
        
        try process.run()
        
        process.waitUntilExit()
        
        guard process.isSuccessfulExit else {
            throw CommandError.runNotSuccessful(
                reason: process.terminationReason,
                status: .init(process.terminationStatus)
            )
        }
        
        return try pipe
            .fileHandleForReading
            .readToEnd()
    }
    
}

// MARK: - Errors

enum CommandError: Error {
    case pathToCommandNotDefined
    case runNotSuccessful(reason: Process.TerminationReason, status: Int)
}

