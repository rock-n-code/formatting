//
//  Process+Computed.swift
//  FormattingCore
//
//  Created by Javier Cicchelli on 27/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import Foundation

extension Process {
    
    // MARK: Computed
    
    var isSuccessfulExit: Bool {
        terminationReason == .exit && terminationStatus == 0
    }
    
}
