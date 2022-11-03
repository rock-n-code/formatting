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
        directory: Path
    ) throws {
        let swiftFormatPath = try context.tool(named: .Commands.swiftFormat).path.string
        let configurationPath = directory.appending(.Defaults.configurationFileName).string

        try FormatSourceCode().callAsFunction(
            commandPath: swiftFormatPath,
            directoryPath: directory.string,
            configurationPath: configurationPath
        )
    }
    
}
