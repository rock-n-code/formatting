//
//  FormatSourceCode.swift
//  FormattingCore
//
//  Created by Javier Cicchelli on 01/11/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import Foundation

struct FormatSourceCode: Action {

    // MARK: Properties
    
    let subCommand: String = .Subcommands.format
    let fileHandler: FileHandler
    let execute: Executable

    // MARK: Functions
    
    init(
        fileHandler: FileHandler = FileManager.default,
        command: Executable = Execution()
    ) {
        self.fileHandler = fileHandler
        self.execute = command
    }
    
    // MARK: Functions

    func callAsFunction(
        commandPath: String,
        configurationPath: String?,
        directoryPath: String?
    ) throws {
        try execute(
            pathToCommand: commandPath,
            arguments: makeArguments(
                options: [
                    .Options.Format.inPlace,
                    .Options.Common.colorDiagnostics,
                    .Options.Common.parallel,
                    .Options.Common.recursive
                ],
                configurationPath: configurationPath,
                directoryPath: directoryPath
            )
        )
    }
    
}
