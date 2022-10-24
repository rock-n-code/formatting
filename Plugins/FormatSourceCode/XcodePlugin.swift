//
//  XcodePlugin.swift
//  FormatSourceCode
//
//  Created by Javier Cicchelli on 24/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

struct XcodePlugin: XcodeCommandPlugin {
    
    // MARK: Functions
    
    func performCommand(
        context: XcodeProjectPlugin.XcodePluginContext,
        arguments: [String]
    ) throws {
        // ...
    }
    
}
#endif
