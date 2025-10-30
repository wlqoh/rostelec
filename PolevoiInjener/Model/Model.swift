import Foundation

// MARK: - ENUMs (значения совпадают с Django TextChoices/ENUM)

enum UserRole: String, Codable, Sendable {
    case engineer, supervisor, admin
}

enum TechType: String, Codable, Sendable {
    case ftth, coax, wireless, dsl, other
}

enum ConnectionStatus: String, Codable, Sendable {
    case available, limited, planned, offline
}

enum ClientStatus: String, Codable, Sendable {
    case not_reached, callback, declined, interested, connected
}

enum Gender: String, Codable, Sendable {
    case male, female, other, unknown
}

enum EmploymentStatus: String, Codable, Sendable {
    case employed, unemployed, student, retired, unknown
}

enum RelationToUnit: String, Codable, Sendable {
    case owner, tenant, relative, unknown
}

enum ScoreType: String, Codable, Sendable {
    case scale, satisfaction
}

enum Satisfaction: String, Codable, Sendable {
    case satisfied, unsatisfied
}

enum TimelineType: String, Codable, Sendable {
    case visit, profile, provider_change, note
}

enum ExportStatus: String, Codable, Sendable {
    case queued, processing, done, failed
}

// для интересов/услуг; код совпадает с backend ServiceType.code (напр. "internet","tv","cctv")
struct ServiceTypeDTO: Codable, Sendable, Identifiable {
    let id: Int64
    let code: String
    let title: String
    let createdAt: Date?
    enum CodingKeys: String, CodingKey { case id, code, title; case createdAt = "created_at" }
}

// MARK: - Базовые справочники

struct CityDTO: Codable, Sendable, Identifiable {
    let id: Int64
    let name: String
    let region: String
    let createdAt: Date?
    enum CodingKeys: String, CodingKey { case id, name, region; case createdAt = "created_at" }
}

struct StreetDTO: Codable, Sendable, Identifiable {
    let id: Int64
    let name: String
    let cityId: Int64
    let createdAt: Date?
    enum CodingKeys: String, CodingKey { case id, name; case cityId = "city_id"; case createdAt = "created_at" }
}

struct ProviderDTO: Codable, Sendable, Identifiable {
    let id: Int64
    let name: String
    let inn: String?
    let meta: [String: String]?
    let createdAt: Date?
    enum CodingKeys: String, CodingKey { case id, name, inn, meta; case createdAt = "created_at" }
}

// MARK: - Объекты, подключения, квартиры

struct ObjectDTO: Codable, Sendable, Identifiable {
    let id: Int64
    let cityId: Int64
    let streetId: Int64
    let gpsLat: Double?
    let gpsLng: Double?
    let createdAt: Date?
    enum CodingKeys: String, CodingKey {
        case id
        case cityId = "city_id"
        case streetId = "street_id"
        case gpsLat = "gps_lat"
        case gpsLng = "gps_lng"
        case createdAt = "created_at"
    }
}

struct ObjectConnectionDTO: Codable, Sendable, Identifiable {
    let id: Int64
    let objectId: Int64
    let providerId: Int64
    let tech: TechType
    let capacity: Int?
    let status: ConnectionStatus
    let updatedAt: Date?
    enum CodingKeys: String, CodingKey {
        case id
        case objectId = "object_id"
        case providerId = "provider_id"
        case tech, capacity, status
        case updatedAt = "updated_at"
    }
}

struct UnitDTO: Codable, Sendable, Identifiable {
    let id: Int64
    let objectId: Int64
    let number: String
    let isRented: Bool
    let currentProviderId: Int64?
    let note: String?
    let historyJSON: UnitHistoryAggregate?
    let createdAt: Date?
    enum CodingKeys: String, CodingKey {
        case id
        case objectId = "object_id"
        case number
        case isRented = "is_rented"
        case currentProviderId = "current_provider_id"
        case note
        case historyJSON = "history_json"
        case createdAt = "created_at"
    }
}

// Быстрый агрегат истории для карточки
struct UnitHistoryAggregate: Codable, Sendable {
    struct Summary: Codable, Sendable {
        let lastProfileStatus: ClientStatus?
        let currentProvider: String?
        let lastInterests: [String]?
        enum CodingKeys: String, CodingKey {
            case lastProfileStatus = "last_profile_status"
            case currentProvider = "current_provider"
            case lastInterests = "last_interests"
        }
    }
    struct Item: Codable, Sendable {
        let snapshotType: TimelineType
        let snapshot: [String: CodableValue] // универсальный JSON
        let createdAt: Date
        enum CodingKeys: String, CodingKey {
            case snapshotType = "snapshot_type"
            case snapshot
            case createdAt = "created_at"
        }
    }
    let summary: Summary
    let recent: [Item]
}

// Универсальный JSON-значимый тип
enum CodableValue: Codable, Sendable {
    case string(String), int(Int), double(Double), bool(Bool), array([CodableValue]), object([String: CodableValue]), null
    init(from decoder: Decoder) throws {
        let c = try decoder.singleValueContainer()
        if c.decodeNil() { self = .null }
        else if let b = try? c.decode(Bool.self) { self = .bool(b) }
        else if let i = try? c.decode(Int.self) { self = .int(i) }
        else if let d = try? c.decode(Double.self) { self = .double(d) }
        else if let s = try? c.decode(String.self) { self = .string(s) }
        else if let a = try? c.decode([CodableValue].self) { self = .array(a) }
        else if let o = try? c.decode([String: CodableValue].self) { self = .object(o) }
        else { throw DecodingError.typeMismatch(CodableValue.self, .init(codingPath: c.codingPath, debugDescription: "Unsupported")) }
    }
    func encode(to encoder: Encoder) throws {
        var c = encoder.singleValueContainer()
        switch self {
        case .null: try c.encodeNil()
        case .bool(let v): try c.encode(v)
        case .int(let v): try c.encode(v)
        case .double(let v): try c.encode(v)
        case .string(let v): try c.encode(v)
        case .array(let v): try c.encode(v)
        case .object(let v): try c.encode(v)
        }
    }
}

// MARK: - Визиты и анкеты

struct VisitDTO: Codable, Sendable, Identifiable {
    let id: Int64
    let objectId: Int64
    let unitId: Int64?
    let visitorId: Int64
    let visitedAt: Date
    let comment: String?
    let createdAt: Date?
    enum CodingKeys: String, CodingKey {
        case id
        case objectId = "object_id"
        case unitId = "unit_id"
        case visitorId = "visitor_id"
        case visitedAt = "visited_at"
        case comment
        case createdAt = "created_at"
    }
}

struct ContactDTO: Codable, Sendable, Identifiable {
    let id: Int64
    let displayName: String?
    let phoneE164: String
    let consentPersonalData: Bool
    let consentMarketing: Bool
    let createdAt: Date?
    enum CodingKeys: String, CodingKey {
        case id
        case displayName = "display_name"
        case phoneE164 = "phone_e164"
        case consentPersonalData = "consent_personal_data"
        case consentMarketing = "consent_marketing"
        case createdAt = "created_at"
    }
}

struct CustomerProfileDTO: Codable, Sendable, Identifiable {
    let id: Int64
    let visitId: Int64
    let contactId: Int64
    let clientStatus: ClientStatus
    let preferredContactTime: String?
    let fairPrice: Decimal?
    let gender: Gender
    let age: Int?
    let employmentStatus: EmploymentStatus
    let relationshipToUnit: RelationToUnit
    let createdAt: Date?
    enum CodingKeys: String, CodingKey {
        case id
        case visitId = "visit_id"
        case contactId = "contact_id"
        case clientStatus = "client_status"
        case preferredContactTime = "preferred_contact_time"
        case fairPrice = "fair_price"
        case gender, age
        case employmentStatus = "employment_status"
        case relationshipToUnit = "relationship_to_unit"
        case createdAt = "created_at"
    }
}

struct CurrentServicesDTO: Codable, Sendable, Identifiable {
    let id: Int64
    let visitId: Int64
    let internet: Bool
    let tv: Bool
    let cctv: Bool
    let nannyInternet: Bool
    let other: String?
    let createdAt: Date?
    enum CodingKeys: String, CodingKey {
        case id
        case visitId = "visit_id"
        case internet, tv, cctv
        case nannyInternet = "nanny_internet"
        case other
        case createdAt = "created_at"
    }
}

struct ProviderRatingDTO: Codable, Sendable, Identifiable {
    let id: Int64
    let visitId: Int64
    let providerId: Int64
    let scoreType: ScoreType
    let scoreValue: Int?
    let satisfaction: Satisfaction?
    let createdAt: Date?
    enum CodingKeys: String, CodingKey {
        case id
        case visitId = "visit_id"
        case providerId = "provider_id"
        case scoreType = "score_type"
        case scoreValue = "score_value"
        case satisfaction
        case createdAt = "created_at"
    }
}

// Интересы визита: связь M2M
struct VisitInterestDTO: Codable, Sendable {
    let visitId: Int64
    let serviceTypeId: Int64
    enum CodingKeys: String, CodingKey {
        case visitId = "visit_id"
        case serviceTypeId = "service_type_id"
    }
}

// MARK: - Таймлайн квартиры (полная история)

struct UnitTimelineDTO: Codable, Sendable, Identifiable {
    let id: Int64
    let unitId: Int64
    let visitId: Int64?
    let snapshotType: TimelineType
    let snapshot: [String: CodableValue]
    let createdAt: Date
    enum CodingKeys: String, CodingKey {
        case id
        case unitId = "unit_id"
        case visitId = "visit_id"
        case snapshotType = "snapshot_type"
        case snapshot
        case createdAt = "created_at"
    }
}

// MARK: - Логи и выгрузки

struct AuditLogDTO: Codable, Sendable, Identifiable {
    let id: Int64
    let entity: String
    let entityId: String
    let action: String
    let userId: Int64?
    let timestamp: Date
    let diff: [String: CodableValue]?
    enum CodingKeys: String, CodingKey {
        case id, entity
        case entityId = "entity_id"
        case action
        case userId = "user_id"
        case timestamp
        case diff
    }
}

struct FileExportDTO: Codable, Sendable, Identifiable {
    let id: Int64
    let kind: String
    let filterParams: [String: CodableValue]
    let fileURL: URL?
    let createdBy: Int64?
    let status: ExportStatus
    let error: String?
    let createdAt: Date
    enum CodingKeys: String, CodingKey {
        case id, kind
        case filterParams = "filter_params"
        case fileURL = "file_url"
        case createdBy = "created_by"
        case status, error
        case createdAt = "created_at"
    }
}
