//
//  LintSourceCode.swift
//  FormattingCore
//
//  Created by Javier Cicchelli on 06/11/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import Foundation

struct LintSourceCode: Action {

    // MARK: Properties
    
    let subCommand: String = .Subcommands.lint
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
