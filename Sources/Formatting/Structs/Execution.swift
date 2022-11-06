//
//  Execution.swift
//  FormattingCore
//
//  Created by Javier Cicchelli on 27/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

#if os(macOS) || targetEnvironment(macCatalyst)
import Foundation

public struct Execution {
    
    // MARK: Properties
    
    public let process: Processable
    public let pipe: Pipable
    
    // MARK: Initialisers
    
    public init(
        process: Processable = Process(),
        pipe: Pipable = Pipe()
    ) {
        self.process = process
        self.pipe = pipe
    }
    
}

// MARK: - Commandable

extension Execution: Executable {
    
    @discardableResult
    public func callAsFunction(
        pathToCommand: String,
        arguments: [String]? = nil
    ) throws -> Data? {
        guard !pathToCommand.isEmpty else {
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

public enum CommandError: Error {
    case pathToCommandNotDefined
    case runNotSuccessful(reason: Process.TerminationReason, status: Int)
}
#endif
