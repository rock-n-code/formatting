//
//  Plugin.swift
//  ResetConfiguration
//
//  Created by Javier Cicchelli on 25/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import PackagePlugin
import Foundation

@main
struct Plugin: CommandPlugin {
    
    // MARK: Properties
    
    private let fileManager: FileManager = .default
    private let process: Process = .init()
    private let pipe: Pipe = .init()
    
    // MARK: Functions
    
    func performCommand(
        context: PackagePlugin.PluginContext,
        arguments: [String]
    ) async throws {
        let swiftFormatPath = try context.tool(named: .Commands.swiftFormat).path.string
        let configurationPath = context.package.directory.appending(subpath: .Defaults.configuratioFile).string
        
        if fileManager.fileExists(atPath: configurationPath),
           fileManager.isDeletableFile(atPath: configurationPath)
        {
            try fileManager.removeItem(atPath: configurationPath)
        }
        
        process.executableURL = .init(fileURLWithPath: swiftFormatPath)
        process.arguments = [
            .Arguments.mode,
            .Arguments.dumpConfiguration
        ]
        process.standardOutput = pipe
        
        try process.run()
        
        process.waitUntilExit()
        
        guard
            process.terminationReason == .exit,
            process.terminationStatus == 0
        else {
            throw CommandError.runNotSuccessful(
                reason: process.terminationReason,
                status: Int(process.terminationStatus)
            )
        }
        
        guard let configurationData = try pipe.fileHandleForReading.readToEnd() else {
            throw CommandError.outputDataNotAvailable
        }
        
        fileManager.createFile(
            atPath: configurationPath,
            contents: configurationData
        )
    }
    
}

// MARK: - Errors

enum CommandError: Error {
    case outputDataNotAvailable
    case runNotSuccessful(reason: Process.TerminationReason, status: Int)
}

// MARK: - String+Constants

private extension String {
    enum Commands {
        static let swiftFormat = "swift-format"
    }
    
    enum Arguments {
        static let mode = "--mode"
        static let dumpConfiguration = "dump-configuration"
    }
    
    enum Defaults {
        static let configuratioFile = ".swift-format.json"
    }
}

