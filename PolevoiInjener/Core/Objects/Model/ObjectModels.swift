//
//  ObjectModels.swift
//  PolevoiInjener
//
//  Created by Codex on 31/10/25.
//

import Foundation

struct ObjectBuilding: Identifiable, Hashable {
    let id: UUID
    let type: String
    let status: String
    let address: String
    let city: String
    let district: String
    let distance: String
    let visits: Int
    let comment: String
    let equipment: [String]
    let technologyCapabilities: [ObjectTechnologyCapability]
    let connectionType: ObjectConnectionType
    var apartments: [ObjectApartment]
}

struct ObjectApartment: Identifiable, Hashable {
    let id: UUID
    let number: String
    let accountNumber: String
    let comment: String
    let tariff: String
    let connectedServices: [String]
    let client: ObjectClient
}

struct ObjectClient: Identifiable, Hashable {
    let id: UUID
    let name: String
    let age: Int
    let occupation: String
    let portrait: String
    let usage: [String]
    let providerSatisfaction: ObjectClientSatisfaction
    let interestedServices: [String]
    let preferredContactTime: String
    let phone: String
    let desiredPrice: String
    let note: String
}

struct ObjectTechnologyCapability: Identifiable, Hashable {
    let id: UUID
    let title: String
    let status: ObjectTechnologyStatus
    let details: String
}

enum ObjectConnectionType: String, Hashable {
    case fiber = "Оптоволокно"
    case twistedPair = "Витая пара"
    case mixed = "Смешанный"
}

enum ObjectTechnologyStatus: Hashable {
    case ready
    case requiresPreparation
    case unavailable

    var title: String {
        switch self {
        case .ready:
            return "Готово"
        case .requiresPreparation:
            return "Требует подготовки"
        case .unavailable:
            return "Недоступно"
        }
    }
}

enum ObjectClientSatisfaction: Hashable {
    case rating(Int)
    case status(String)

    var description: String {
        switch self {
        case .rating(let score):
            return "Оценка: \(score) из 5"
        case .status(let value):
            return value
        }
    }
}
