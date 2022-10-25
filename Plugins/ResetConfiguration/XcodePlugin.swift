//
//  XcodePlugin.swift
//  FormatSourceCode
//
//  Created by Javier Cicchelli on 25/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin
import Foundation

struct XcodePlugin: XcodeCommandPlugin {
    
    // MARK: Properties
    
    private let fileManager: FileManager = .default
    private let process: Process = .init()
    private let pipe: Pipe = .init()
    
    // MARK: Functions
    
    func performCommand(
        context: XcodeProjectPlugin.XcodePluginContext,
        arguments: [String]
    ) throws {
        let swiftFormatPath = try context.tool(named: .Commands.swiftFormat).path.string
        let configurationPath = context.xcodeProject.directory.appending(subpath: .Defaults.configuratioFile).string
        
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
#endif
