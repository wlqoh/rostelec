//
//  ObjectDestination.swift
//  PolevoiInjener
//
//  Created by Codex on 31/10/25.
//

import Foundation

enum ObjectDestination: Hashable {
    case building(ObjectBuilding)
    case apartment(ObjectApartment)
    case client(ObjectClient)
}
