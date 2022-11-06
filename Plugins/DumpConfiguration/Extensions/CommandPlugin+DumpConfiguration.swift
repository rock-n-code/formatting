//
//  CommandPlugin+DumpConfiguration.swift
//  DumpConfiguration
//
//  Created by Javier Cicchelli on 03/11/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import PackagePlugin

extension CommandPlugin {
    
    // MARK: Functions
    
    func dumpConfiguration(
        context: Toolable,
        directory: Path,
        arguments: [String]
    ) throws {
        var argumentExtractor = ArgumentExtractor(arguments)
        
        let dumpConfiguration = DumpConfiguration()
        let swiftFormatPath = try context.tool(named: .Commands.swiftFormat).path.string
        let configurationPath = directory.appending(.Defaults.configurationFileName).string
        let helpOption = argumentExtractor.extractFlag(named: .Options.Common.help)
        
        helpOption == 1
            ? try dumpConfiguration(commandPath: swiftFormatPath)
            : try dumpConfiguration(
                commandPath: swiftFormatPath,
                configurationPath: configurationPath
            )
    }
    
}
