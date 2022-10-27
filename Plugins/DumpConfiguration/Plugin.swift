//
//  Plugin.swift
//  ResetConfiguration
//
//  Created by Javier Cicchelli on 25/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import PackagePlugin

@main
struct Plugin {
    
    // MARK: Properties
    
    private let dumpConfiguration = DumpConfiguration()
    
}

// MARK: - CommandPlugin

extension Plugin: CommandPlugin {

    // MARK: Functions

    func performCommand(
        context: PackagePlugin.PluginContext,
        arguments: [String]
    ) throws {
        let swiftFormatPath = try context.tool(named: .Commands.swiftFormat).path.string
        let configurationPath = context.package.directory.appending(subpath: .Defaults.configurationFileName).string
        
        try dumpConfiguration(
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
        let configurationPath = context.xcodeProject.directory.appending(subpath: .Defaults.configurationFileName).string
        
        try dumpConfiguration(
            commandPath: swiftFormatPath,
            configurationPath: configurationPath
        )
    }
    
}
#endif
