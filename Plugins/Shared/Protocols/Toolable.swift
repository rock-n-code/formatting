//
//  Toolable.swift
//  PluginShared
//
//  Created by Javier Cicchelli on 02/11/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import PackagePlugin

protocol Toolable {
    func tool(named name: String) throws -> PluginContext.Tool
}
