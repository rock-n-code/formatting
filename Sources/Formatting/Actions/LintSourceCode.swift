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
    
    let fileHandler: FileHandler
    let command: Commandable
    var subCommand: String = .Subcommands.lint
    
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
        configurationPath: String?,
        directoryPath: String?
    ) throws {
        try command(
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
