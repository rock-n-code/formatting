//
//  FileHandler.swift
//  FormattingCore
//
//  Created by Javier Cicchelli on 27/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import Foundation

protocol FileHandler {
    
    // MARK: Functions
    
    func fileExists(atPath path: String) -> Bool
    
    func isDeletableFile(atPath path: String) -> Bool
    
    func removeItem(atPath path: String) throws
    
    @discardableResult
    func createFile(
        atPath path: String,
        contents data: Data?,
        attributes attr: [FileAttributeKey : Any]?
    ) -> Bool
    
}
