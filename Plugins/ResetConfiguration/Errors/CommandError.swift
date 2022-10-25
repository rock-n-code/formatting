//
//  CommandError.swift
//  ResetConfiguration
//
//  Created by Javier Cicchelli on 26/10/2022.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import Foundation

enum CommandError: Error {
    case outputDataNotAvailable
    case runNotSuccessful(reason: Process.TerminationReason, status: Int)
}
