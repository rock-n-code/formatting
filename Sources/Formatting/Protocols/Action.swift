//
//  Action.swift
//  FormattingCore
//
//  Created by Javier Cicchelli on 06/11/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

protocol Action  {
    
    // MARK: Properties
    
    var subCommand: String { get }
    var fileHandler: FileHandler { get }
    var execute: Executable { get }

    // MARK: Functions
    
    func callAsFunction(
        commandPath: String,
        configurationPath: String?,
        directoryPath: String?
    ) throws
    
}

// MARK: - Defaults

extension Action {
    
    // MARK: Functions
    
    func callAsFunction(commandPath: String) throws {
        try execute(
            pathToCommand: commandPath,
            arguments: makeArguments(
                options: [.Options.Common.help]
            )
        )
    }
    
    func makeArguments(
        options: [String] = [],
        configurationPath: String? = nil,
        directoryPath: String? = nil
    ) -> [String] {
        var arguments: [String] = [subCommand] + options

        if let configurationPath,
           fileHandler.fileExists(atPath: configurationPath)
        {
            arguments.append(contentsOf: [
                .Options.Common.configuration,
                configurationPath
            ])
        }
        
        if let directoryPath {
            arguments.append(directoryPath)
        }

        return arguments
    }
    
}
