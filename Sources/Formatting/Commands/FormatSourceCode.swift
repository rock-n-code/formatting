//
//  FormatSourceCode.swift
//  FormattingCore
//
//  Created by Javier Cicchelli on 01/11/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import Foundation

struct FormatSourceCode {
    
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
        rootFolderPath: String,
        configurationPath: String?
    ) throws {
        try command(
            pathToCommand: commandPath,
            arguments: makeArguments(
                rootFolderPath: rootFolderPath,
                configurationPath: configurationPath
            )
        )
    }
    
}

// MARK: - Helpers

private extension FormatSourceCode {
    
    // MARK: Functions
    
    func makeArguments(
        rootFolderPath: String,
        configurationPath: String?
    ) -> [String] {
        var arguments: [String] = [
            .Subcommands.format,
            .Options.inPlace,
            .Options.parallel,
            .Options.recursive
        ]
        
        if let configurationPath,
           fileHandler.fileExists(atPath: configurationPath)
        {
            arguments.append(contentsOf: [
                .Options.configuration,
                configurationPath
            ])
        }
        
        arguments.append(rootFolderPath)
        
        return arguments
    }
}
