//
//  Processable.swift
//  FormattingCore
//
//  Created by Javier Cicchelli on 31/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

#if os(macOS) || targetEnvironment(macCatalyst)
import Foundation

public protocol Processable: AnyObject {
    
    // MARK: Properties
    
    var executableURL: URL? { get set }
    var arguments: [String]? { get set }
    var standardOutput: Any? { get set }
    
    // MARK: Computed
    
    var terminationReason: Process.TerminationReason { get }
    var terminationStatus: Int32 { get }
    var isSuccessfulExit: Bool { get }
    
    // MARK: Functions
    
    func run() throws
    func waitUntilExit()
    
}
#endif
