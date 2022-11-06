//
//  DumpConfiguration.swift
//  FormattingCore
//
//  Created by Javier Cicchelli on 27/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import Foundation

struct DumpConfiguration: Action {

    // MARK: Properties
    
    let fileHandler: FileHandler
    let command: Commandable
    let subCommand: String = .Subcommands.dumpConfiguration
    
    // MARK: Functions
    
    init(
        fileHandler: FileHandler = FileManager.default,
        command: Commandable = Command()
    ) {
        self.fileHandler = fileHandler
        self.command = command
    }
    
    // MARK: Functions
    
    func callAsFunction(
        commandPath: String,
        configurationPath: String? = nil,
        directoryPath: String? = nil
    ) throws {
        guard let configurationPath else {
            assertionFailure("The configuration path should have been defined.")
            return
        }
        
        if fileHandler.fileExists(atPath: configurationPath),
           fileHandler.isDeletableFile(atPath: configurationPath)
        {
            try fileHandler.removeItem(atPath: configurationPath)
        }
        
        let configurationData = try command(
            pathToCommand: commandPath,
            arguments: makeArguments()
        )
        
        fileHandler.createFile(
            atPath: configurationPath,
            contents: configurationData,
            attributes: nil
        )
    }
    
}
