//
//  String+Options.swift
//  FormattingCore
//
//  Created by Javier Cicchelli on 26/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

extension String {
    enum Options {
        enum Format {
            static let inPlace = "--in-place"
        }
        
        enum Lint {
            static let strict = "--strict"
        }
        
        enum Common {
            static let assumeFilename = "--asume-filename"
            static let colorDiagnostics = "--color-diagnostics"
            static let noColorDiagnostics = "--no-color-diagnostics"
            static let ignoreUnparsableFiles = "--ignore-unparsable-files"
            static let configuration = "--configuration"
            static let parallel = "--parallel"
            static let recursive = "--recursive"
            static let version = "--version"
            static let help = "--help"
        }
    }
}
