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
        directory: Path
    ) throws {
        let swiftFormatPath = try context.tool(named: .Commands.swiftFormat).path.string
        let configurationPath = directory.appending(.Defaults.configurationFileName).string
        
        try DumpConfiguration().callAsFunction(
            commandPath: swiftFormatPath,
            configurationPath: configurationPath
        )
    }
    
}
