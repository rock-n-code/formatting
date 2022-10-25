//
//  String+Constants.swift
//  ResetConfiguration
//
//  Created by Javier Cicchelli on 26/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

extension String {
    enum Commands {
        static let swiftFormat = "swift-format"
    }
    
    enum Arguments {
        static let mode = "--mode"
        static let dumpConfiguration = "dump-configuration"
    }
    
    enum Defaults {
        static let configuratioFile = ".swift-format.json"
    }
}

