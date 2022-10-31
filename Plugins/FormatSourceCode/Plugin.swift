//
//  Plugin.swift
//  FormatSourceCode
//
//  Created by Javier Cicchelli on 01/11/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import PackagePlugin

@main
struct Plugin {
    
    // MARK: Properties
    
    private let formatSourceCode = FormatSourceCode()
    
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
        
        try context.package.targets.forEach { target in
            try formatSourceCode(
                commandPath: swiftFormatPath,
                rootFolderPath: target.directory.string,
                configurationPath: configurationPath
            )
        }
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
        
        try formatSourceCode(
            commandPath: swiftFormatPath,
            rootFolderPath: context.xcodeProject.directory.string,
            configurationPath: configurationPath
        )
    }
    
}
#endif
