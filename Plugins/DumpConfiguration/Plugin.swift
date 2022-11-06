//
//  Plugin.swift
//  DumpConfiguration
//
//  Created by Javier Cicchelli on 25/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import PackagePlugin

@main
struct Plugin {}

// MARK: - CommandPlugin

extension Plugin: CommandPlugin {

    // MARK: Functions

    func performCommand(
        context: PackagePlugin.PluginContext,
        arguments: [String]
    ) throws {
        try dumpConfiguration(
            context: context,
            directory: context.package.directory,
            arguments: arguments
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
        try dumpConfiguration(
            context: context,
            directory: context.xcodeProject.directory,
            arguments: arguments
        )
    }
    
}
#endif
