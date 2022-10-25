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
struct Plugin {
    
    // MARK: Properties
    
    let fileManager: FileManager = .default
    
}

// MARK: - CommandPlugin

extension Plugin: CommandPlugin {

    // MARK: Functions
    
    func performCommand(
        context: PackagePlugin.PluginContext,
        arguments: [String]
    ) async throws {
        let swiftFormatPath = try context.tool(named: .Commands.swiftFormat).path.string
        let configurationPath = context.package.directory.appending(subpath: .Defaults.configuratioFile).string
        
        try execute(
            commandPath: swiftFormatPath,
            configurationPath: configurationPath
        )
    }
    
}

// MARK: - XcodeCommandPlugin

#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

extension Plugin: XcodeCommandPlugin {
    
    // MARK: Functions
    
    func performCommand(
        context: XcodeProjectPlugin.XcodePluginContext,
        arguments: [String]
    ) throws {
        let swiftFormatPath = try context.tool(named: .Commands.swiftFormat).path.string
        let configurationPath = context.xcodeProject.directory.appending(subpath: .Defaults.configuratioFile).string
        
        try execute(
            commandPath: swiftFormatPath,
            configurationPath: configurationPath
        )
    }
    
}
#endif

// MARK: - Helpers

private extension Plugin {
    
    // MARK: Functions
    
    func execute(
        commandPath: String,
        configurationPath: String
    ) throws {
        if fileManager.fileExists(atPath: configurationPath),
           fileManager.isDeletableFile(atPath: configurationPath)
        {
            try fileManager.removeItem(atPath: configurationPath)
        }
        
        let process = Process()
        let pipe = Pipe()
        
        process.executableURL = .init(fileURLWithPath: commandPath)
        process.standardOutput = pipe
        process.arguments = [
            .Arguments.mode,
            .Arguments.dumpConfiguration
        ]

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
