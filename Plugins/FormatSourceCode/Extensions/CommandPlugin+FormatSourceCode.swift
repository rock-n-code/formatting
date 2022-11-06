//
//  CommandPlugin+FormatSourceCode.swift
//  FormatSourceCode
//
//  Created by Javier Cicchelli on 03/11/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import PackagePlugin

extension CommandPlugin {
    
    // MARK: Functions
    
    func formatSourceCode(
        context: Toolable,
        directory: Path,
        arguments: [String]
    ) throws {
        var argumentExtractor = ArgumentExtractor(arguments)
        
        let formatSourceCode = FormatSourceCode()
        let swiftFormatPath = try context.tool(named: .Commands.swiftFormat).path.string
        let configurationPath = directory.appending(.Defaults.configurationFileName).string
        let helpOption = argumentExtractor.extractFlag(named: .Options.Common.help)

        helpOption == 1
            ? try formatSourceCode(commandPath: swiftFormatPath)
            : try formatSourceCode(
                commandPath: swiftFormatPath,
                configurationPath: configurationPath,
                directoryPath: directory.string
            )
    }
    
}
