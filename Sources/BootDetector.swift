//
//  BootDetector.swift
//  Kronos
//
//  Created by Simone Andreani on 20/11/2018.
//  Copyright © 2018 Lyft. All rights reserved.
//

import Foundation
import Darwin

internal struct BootDetector {
    private static let semaphore_mode: mode_t = S_IWUSR | S_IRUSR | S_IRGRP | S_IROTH

    private static func semName(for flagName: String?) -> String {
        return "kronos_\(flagName ?? "default")"
    }

    public static func getBootVolatileFlag(_ flagName: String?) -> Bool {
        let sem_name = semName(for: flagName)

        let semaphore = sem_open(sem_name, 0, semaphore_mode, 0)
        var error = Int32(0)
        var flagval = Int(0)

        if SEM_FAILED == semaphore {
            error = errno
        } else {
            sem_close(semaphore)
        }

        if error == 0 {
            flagval += 1
        }

        return flagval == 1
    }

    public static func setBootVolatileFlag(_ flagName: String?) {
        let sem_name = semName(for: flagName)

        let semaphore = sem_open(sem_name, O_CREAT | O_EXCL, semaphore_mode, 0)

        if SEM_FAILED != semaphore {
            sem_close(semaphore)
        }
    }
}
