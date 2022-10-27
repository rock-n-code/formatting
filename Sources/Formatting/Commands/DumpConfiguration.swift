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
    private let run: Runnable
    
    // MARK: Functions
    
    init(
        fileHandler: FileHandler = FileManager.default,
        run: Runnable = Command()
    ) {
        self.fileHandler = fileHandler
        self.run = run
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
        
        let configurationData = try run(
            pathToCommand: commandPath,
            arguments: [.Arguments.dumpConfiguration]
        )
        
        fileHandler.createFile(
            atPath: configurationPath,
            contents: configurationData,
            attributes: nil
        )
    }
    
}
