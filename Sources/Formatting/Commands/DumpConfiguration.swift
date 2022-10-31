//
//  DumpConfiguration.swift
//  FormattingCore
//
//  Created by Javier Cicchelli on 27/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import Foundation

struct DumpConfiguration {
    
    // MARK: Properties
    
    private let fileHandler: FileHandler
    private let command: Commandable
    
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
        configurationPath: String
    ) throws {
        if fileHandler.fileExists(atPath: configurationPath),
           fileHandler.isDeletableFile(atPath: configurationPath)
        {
            try fileHandler.removeItem(atPath: configurationPath)
        }
        
        let configurationData = try command(
            pathToCommand: commandPath,
            arguments: [.Subcommands.dumpConfiguration]
        )
        
        fileHandler.createFile(
            atPath: configurationPath,
            contents: configurationData,
            attributes: nil
        )
    }
    
}
