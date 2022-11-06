//
//  CommandPlugin+LintSourceCode.swift
//  LintSourceCode
//
//  Created by Javier Cicchelli on 05/11/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import PackagePlugin

extension CommandPlugin {
    
    // MARK: Functions
    
    func lintSourceCode(
        context: Toolable,
        directory: Path,
        arguments: [String]
    ) throws {
        var argumentExtractor = ArgumentExtractor(arguments)
        
        let lintSourceCode = LintSourceCode()
        let swiftFormatPath = try context.tool(named: .Commands.swiftFormat).path.string
        let configurationPath = directory.appending(.Defaults.configurationFileName).string
        let helpOption = argumentExtractor.extractFlag(named: .Options.Common.help)
        
        helpOption == 1
            ? try lintSourceCode(commandPath: swiftFormatPath)
            : try lintSourceCode(
                commandPath: swiftFormatPath,
                configurationPath: configurationPath,
                directoryPath: directory.string
            )
    }
    
}
