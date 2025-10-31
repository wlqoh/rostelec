//
//  ClientDetailView.swift
//  PolevoiInjener
//
//  Created by Codex on 31/10/25.
//

import SwiftUI

struct ClientDetailView: View {
    let client: ObjectClient

    private let gridColumns = [
        GridItem(.flexible(minimum: 120), spacing: 10),
        GridItem(.flexible(minimum: 120), spacing: 10)
    ]

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 22) {
                header
                portraitCard
                usageCard
                satisfactionCard
                contactCard
                noteCard
            }
            .padding(.horizontal, 20)
            .padding(.top, 28)
            .padding(.bottom, 120)
        }
        .background(Color.theme.backgroundColor.ignoresSafeArea())
        .navigationTitle("Клиент")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {}) {
                    Image(systemName: "square.and.pencil")
                        .font(.system(size: 16, weight: .semibold))
                }
                .buttonStyle(.plain)
                .foregroundStyle(Color.theme.secondaryColor)
            }
        }
    }
}

// MARK: - Subviews

private extension ClientDetailView {
    var header: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(client.name)
                .font(.system(size: 28, weight: .bold))

            if !clientHeaderSubtitle.isEmpty {
                Text(clientHeaderSubtitle)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(Color.white.opacity(0.65))
            }
        }
    }

    var portraitCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Портрет клиента")
                .font(.system(size: 18, weight: .semibold))

            Text(client.portrait)
                .font(.system(size: 15, weight: .regular))
                .foregroundStyle(Color.white.opacity(0.85))
                .fixedSize(horizontal: false, vertical: true)
        }
        .objectsCard()
    }

    var usageCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Чем пользуется")
                .font(.system(size: 18, weight: .semibold))

            if client.usage.isEmpty {
                Text("Нет подключённых услуг. Заполните данные после визита.")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color.white.opacity(0.6))
            } else {
                LazyVGrid(columns: gridColumns, alignment: .leading, spacing: 10) {
                    ForEach(client.usage, id: \.self) { usage in
                        ObjectsPill(
                            text: usage,
                            foreground: Color.white.opacity(0.9),
                            background: Color.theme.primaryColor.opacity(0.7)
                        )
                    }
                }
            }
        }
        .objectsCard()
    }

    var satisfactionCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Отношение к текущему провайдеру")
                .font(.system(size: 18, weight: .semibold))

            infoRow(icon: "hand.thumbsup", title: "Оценка", value: client.providerSatisfaction.description)

            if !client.interestedServices.isEmpty {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Интерес к услугам Ростелекома")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(Color.white.opacity(0.55))

                    LazyVGrid(columns: gridColumns, alignment: .leading, spacing: 10) {
                        ForEach(client.interestedServices, id: \.self) { service in
                            ObjectsPill(
                                text: service,
                                foreground: Color.white.opacity(0.85),
                                background: Color.theme.primaryColor.opacity(0.55)
                            )
                        }
                    }
                }
            } else {
                Text("Пока не интересовался дополнительными услугами.")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color.white.opacity(0.6))
            }
        }
        .objectsCard()
    }

    var contactCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Контактные данные")
                .font(.system(size: 18, weight: .semibold))

            infoRow(icon: "clock", title: "Удобное время для связи", value: client.preferredContactTime)
            infoRow(icon: "phone.fill", title: "Телефон", value: client.phone)
            infoRow(icon: "rublesign.circle", title: "Желаемая цена за интернет", value: client.desiredPrice)
        }
        .objectsCard()
    }

    var noteCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Примечание инженера")
                .font(.system(size: 18, weight: .semibold))

            Text(client.note)
                .font(.system(size: 15, weight: .regular))
                .foregroundStyle(Color.white.opacity(0.85))
                .fixedSize(horizontal: false, vertical: true)

            Button(action: {}) {
                Label("Редактировать или дополнить", systemImage: "square.and.pencil")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.theme.secondaryColor)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(
                        Capsule(style: .continuous)
                            .fill(Color.theme.secondaryColor.opacity(0.15))
                    )
            }
            .buttonStyle(.plain)
        }
        .objectsCard()
    }

    var clientHeaderSubtitle: String {
        let ageText: String? = client.age > 0 ? "\(client.age) лет" : nil
        let occupationText = client.occupation.isEmpty ? nil : client.occupation
        let parts = [ageText, occupationText].compactMap { $0 }
        return parts.joined(separator: " • ")
    }

    func infoRow(icon: String, title: String, value: String) -> some View {
        HStack(alignment: .center, spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(Color.theme.secondaryColor)
                .frame(width: 28)
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(Color.white.opacity(0.55))
                Text(value)
                    .font(.system(size: 16, weight: .semibold))
            }
        }
    }
}
