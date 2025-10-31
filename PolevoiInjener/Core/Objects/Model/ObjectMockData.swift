//
//  ObjectMockData.swift
//  PolevoiInjener
//
//  Created by Codex on 31/10/25.
//

import Foundation

enum ObjectMockData {
    static var buildings: [ObjectBuilding] = [
        ObjectBuilding(
            id: UUID(),
            type: "МКД",
            status: "В работе",
            address: "ул. Пушкина, д. 12",
            city: "Москва",
            district: "Центральный",
            distance: "3.2 км",
            visits: 45,
            comment: "Дом с активной базой абонентов. Необходимо проверить состояние стояков и подготовить площадку под установку дополнительного оборудования.",
            equipment: [
                "Оптический кросс в подъезде №1",
                "Коммутатор на 24 порта (подвал)",
                "Резервный аккумулятор APC"
            ],
            technologyCapabilities: [
                ObjectTechnologyCapability(
                    id: UUID(),
                    title: "xPON (GPON)",
                    status: .ready,
                    details: "Оптика заведена на все этажи, есть свободные порты в разветвителе."
                ),
                ObjectTechnologyCapability(
                    id: UUID(),
                    title: "LAN (витая пара)",
                    status: .requiresPreparation,
                    details: "Состояние старых линий требует диагностики, возможна частичная замена."
                ),
                ObjectTechnologyCapability(
                    id: UUID(),
                    title: "ТВ (DVB-C)",
                    status: .ready,
                    details: "Коллективная антенна и усилитель находятся в рабочем состоянии."
                )
            ],
            connectionType: .fiber,
            apartments: [
                ObjectApartment(
                    id: UUID(),
                    number: "14",
                    accountNumber: "40817-382",
                    comment: "Есть претензии к стабильности Wi-Fi, проверить радиообстановку.",
                    tariff: "Домашний 500 Мбит/с + ТВ",
                    connectedServices: ["Интернет", "Цифровое ТВ"],
                    client: ObjectClient(
                        id: UUID(),
                        name: "Сергей Петров",
                        age: 42,
                        occupation: "Менеджер по продажам",
                        portrait: "Мужчина, 40-45 лет, работает из дома, часто отправляется в командировки.",
                        usage: ["Интернет", "ТВ"],
                        providerSatisfaction: .rating(4),
                        interestedServices: ["Домашний Wi-Fi 6", "Усилитель сигнала"],
                        preferredContactTime: "Будние 18:00–21:00",
                        phone: "+7 (999) 123-45-67",
                        desiredPrice: "до 900 ₽/мес",
                        note: "Рассматривает подключение умного дома, уточнить комплект."
                    )
                ),
                ObjectApartment(
                    id: UUID(),
                    number: "27",
                    accountNumber: "40817-521",
                    comment: "Услуги подключены недавно, важно собрать обратную связь.",
                    tariff: "Игровой 700 Мбит/с",
                    connectedServices: ["Интернет"],
                    client: ObjectClient(
                        id: UUID(),
                        name: "Диана Власова",
                        age: 28,
                        occupation: "Разработчик игр",
                        portrait: "Женщина, 25-30 лет, активно пользуется интернетом для работы и стриминга.",
                        usage: ["Интернет", "Видеонаблюдение"],
                        providerSatisfaction: .status("Удовлетворена"),
                        interestedServices: ["Интернет-няня", "Резервный канал связи"],
                        preferredContactTime: "Будние 12:00–15:00",
                        phone: "+7 (915) 555-21-34",
                        desiredPrice: "до 1 200 ₽/мес",
                        note: "Готова выступить референсом, если решим проблему с пингом."
                    )
                ),
                ObjectApartment(
                    id: UUID(),
                    number: "48",
                    accountNumber: "40817-804",
                    comment: "Старый клиент, давно не обновлял тариф.",
                    tariff: "Комфорт 300 Мбит/с",
                    connectedServices: ["Интернет", "ТВ", "Видеонаблюдение"],
                    client: ObjectClient(
                        id: UUID(),
                        name: "Анна Смирнова",
                        age: 51,
                        occupation: "Бухгалтер",
                        portrait: "Женщина, 50-55 лет, предпочитает стабильность, редко меняет услуги.",
                        usage: ["Интернет", "ТВ"],
                        providerSatisfaction: .rating(3),
                        interestedServices: ["Интернет-няня"],
                        preferredContactTime: "Выходные 11:00–14:00",
                        phone: "+7 (929) 888-44-55",
                        desiredPrice: "до 750 ₽/мес",
                        note: "Сомневается в необходимости видеонаблюдения, обсудить пакетное предложение."
                    )
                )
            ]
        ),
        ObjectBuilding(
            id: UUID(),
            type: "Бизнес-центр",
            status: "Новый",
            address: "пр-т Ленина, д. 50",
            city: "Москва",
            district: "Северный",
            distance: "5.4 км",
            visits: 6,
            comment: "Заполняемость высокая, запрос на подключение нескольких офисов. Проверить возможность размещения стойки.",
            equipment: [
                "Стойка 42U на техническом этаже",
                "Два коммутатора 48 портов",
                "ИБП Eaton (4 часа автономии)"
            ],
            technologyCapabilities: [
                ObjectTechnologyCapability(
                    id: UUID(),
                    title: "Опорный канал 10 Гбит/с",
                    status: .ready,
                    details: "Развернут магистральный канал, есть резерв по витой паре."
                ),
                ObjectTechnologyCapability(
                    id: UUID(),
                    title: "Wi-Fi покрытие",
                    status: .requiresPreparation,
                    details: "Необходимо установить дополнительные точки доступа в восточном крыле."
                ),
                ObjectTechnologyCapability(
                    id: UUID(),
                    title: "Система видеонаблюдения",
                    status: .unavailable,
                    details: "Помещение ещё не подготовлено, требуется согласование с арендатором."
                )
            ],
            connectionType: .mixed,
            apartments: [
                ObjectApartment(
                    id: UUID(),
                    number: "Офис 215",
                    accountNumber: "BC-10215",
                    comment: "Ведут переговоры о подключении резервного канала.",
                    tariff: "Бизнес 1 Гбит/с",
                    connectedServices: ["Интернет", "Видеонаблюдение"],
                    client: ObjectClient(
                        id: UUID(),
                        name: "ООО «Импульс»",
                        age: 0,
                        occupation: "Digital-агентство",
                        portrait: "Коллектив 15 человек, критична стабильность и SLA.",
                        usage: ["Интернет", "Видеонаблюдение"],
                        providerSatisfaction: .status("Удовлетворены"),
                        interestedServices: ["Резервный канал", "IP-телефония"],
                        preferredContactTime: "Будние 10:00–18:00",
                        phone: "+7 (495) 101-40-10",
                        desiredPrice: "до 8 000 ₽/мес",
                        note: "Ожидают коммерческое предложение, интересует гибкость тарифа."
                    )
                ),
                ObjectApartment(
                    id: UUID(),
                    number: "Офис 402",
                    accountNumber: "BC-10402",
                    comment: "Остались вопросы по скорости доступа во внутреннюю сеть.",
                    tariff: "Бизнес 500 Мбит/с",
                    connectedServices: ["Интернет"],
                    client: ObjectClient(
                        id: UUID(),
                        name: "ИП Крылов",
                        age: 34,
                        occupation: "Финансовые консультации",
                        portrait: "Мужчина, 30-35 лет, часто работает с клиентами по видеосвязи.",
                        usage: ["Интернет"],
                        providerSatisfaction: .rating(5),
                        interestedServices: ["Защищённый VPN", "Интернет-няня"],
                        preferredContactTime: "Будние 09:00–12:00",
                        phone: "+7 (903) 777-00-11",
                        desiredPrice: "до 5 500 ₽/мес",
                        note: "Готов рекомендовать услуги, если решим вопрос с VPN."
                    )
                )
            ]
        )
    ]
}
