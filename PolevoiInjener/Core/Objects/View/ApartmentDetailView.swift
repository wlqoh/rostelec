//
//  ApartmentDetailView.swift
//  PolevoiInjener
//
//  Created by Codex on 31/10/25.
//

import SwiftUI

struct ApartmentDetailView: View {
    let apartment: ObjectApartment

    private let gridColumns = [
        GridItem(.flexible(minimum: 120), spacing: 10),
        GridItem(.flexible(minimum: 120), spacing: 10)
    ]

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 22) {
                header
                accountCard
                commentCard
                servicesCard
                clientSection
            }
            .padding(.horizontal, 20)
            .padding(.top, 28)
            .padding(.bottom, 120)
        }
        .background(Color.theme.backgroundColor.ignoresSafeArea())
        .navigationTitle("Квартира \(apartment.number)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Subviews

private extension ApartmentDetailView {
    var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Лицевой счёт")
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(Color.white.opacity(0.55))

            Text(apartment.accountNumber)
                .font(.system(size: 24, weight: .bold))

            if !clientSummary.isEmpty {
                Text(clientSummary)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(Color.white.opacity(0.65))
            }
        }
    }

    var accountCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Подключённый тариф")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(Color.white.opacity(0.55))
                Text(apartment.tariff)
                    .font(.system(size: 17, weight: .semibold))
            }

            Divider()
                .overlay(Color.white.opacity(0.05))

            Text("Квартира прикреплена к клиенту ниже. Можно отредактировать данные и выбрать новый тариф во время повторного визита.")
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(Color.white.opacity(0.55))
        }
        .objectsCard()
    }

    var commentCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Комментарий к квартире")
                .font(.system(size: 18, weight: .semibold))

            Text(apartment.comment)
                .font(.system(size: 15, weight: .regular))
                .foregroundStyle(Color.white.opacity(0.85))
                .fixedSize(horizontal: false, vertical: true)
        }
        .objectsCard()
    }

    var servicesCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Подключённые услуги")
                .font(.system(size: 18, weight: .semibold))

            if apartment.connectedServices.isEmpty {
                Text("Нет активных услуг. Предложите клиенту подходящие решения во время визита.")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color.white.opacity(0.6))
            } else {
                LazyVGrid(columns: gridColumns, alignment: .leading, spacing: 10) {
                    ForEach(apartment.connectedServices, id: \.self) { service in
                        ObjectsPill(
                            text: service,
                            foreground: Color.white.opacity(0.9),
                            background: Color.theme.primaryColor.opacity(0.7)
                        )
                    }
                }
            }
        }
        .objectsCard()
    }

    var clientSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Клиент")
                .font(.system(size: 18, weight: .semibold))

            NavigationLink(value: ObjectDestination.client(apartment.client)) {
                HStack(alignment: .center, spacing: 16) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(apartment.client.name)
                            .font(.system(size: 17, weight: .semibold))

                        if !clientSummary.isEmpty {
                            Text(clientSummary)
                                .font(.system(size: 13, weight: .medium))
                                .foregroundStyle(Color.white.opacity(0.65))
                        }

                        HStack(spacing: 6) {
                            ForEach(apartment.client.usage.prefix(3), id: \.self) { usage in
                                ObjectsPill(
                                    text: usage,
                                    foreground: Color.white.opacity(0.85),
                                    background: Color.theme.primaryColor.opacity(0.55)
                                )
                            }
                        }
                    }

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Color.white.opacity(0.4))
                }
                .padding(18)
                .background(
                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                        .fill(Color.theme.primaryColor)
                        .overlay(
                            RoundedRectangle(cornerRadius: 22, style: .continuous)
                                .stroke(Color.white.opacity(0.05), lineWidth: 1)
                        )
                )
            }
            .buttonStyle(.plain)
        }
        .objectsCard()
    }

    var clientSummary: String {
        let ageText: String? = apartment.client.age > 0 ? "\(apartment.client.age) лет" : nil
        let occupationText = apartment.client.occupation.isEmpty ? nil : apartment.client.occupation
        let parts = [ageText, occupationText].compactMap { $0 }
        return parts.joined(separator: " • ")
    }
}
