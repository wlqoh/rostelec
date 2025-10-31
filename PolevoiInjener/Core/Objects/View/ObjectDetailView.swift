//
//  ObjectDetailView.swift
//  PolevoiInjener
//
//  Created by Codex on 31/10/25.
//

import SwiftUI

struct ObjectDetailView: View {
    let building: ObjectBuilding
    @State private var textEdit = ""

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 22) {
                header
                summaryCard
                commentCard
                equipmentCard
                capabilitiesCard
                apartmentsSection
            }
            .padding(.horizontal, 20)
            .padding(.top, 28)
            .padding(.bottom, 120)
        }
        .background(Color.theme.backgroundColor.ignoresSafeArea())
        .navigationTitle("Объект")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Subviews

private extension ObjectDetailView {
    var header: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                ObjectsPill(text: building.type, foreground: Color.white.opacity(0.85), background: Color.white.opacity(0.1))
                ObjectsPill(text: building.status, background: Color.theme.secondaryColor)
                ObjectsPill(text: building.connectionType.rawValue, foreground: Color.white.opacity(0.85), background: Color.theme.primaryColor.opacity(0.6))
            }

            Text(building.address)
                .font(.system(size: 28, weight: .bold))

            Text("\(building.city) • \(building.district)")
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(Color.white.opacity(0.65))
        }
    }

    var summaryCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            infoRow(icon: "location.north.fill", title: "Расстояние до объекта", value: building.distance)
            infoRow(icon: "clock.badge.checkmark", title: "Последних визитов", value: "\(building.visits)")
        }
        .objectsCard()
    }

    var commentCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionTitle("Комментарий к дому")
            TextEditor(text: $textEdit)
                .onAppear {
                    if textEdit.isEmpty {
                        textEdit = building.comment
                    }
                }
        }
        .objectsCard()
    }

    var equipmentCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionTitle("Оборудование")

            VStack(alignment: .leading, spacing: 10) {
                ForEach(building.equipment, id: \.self) { item in
                    HStack(alignment: .top, spacing: 10) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(Color.theme.secondaryColor)
                            .font(.system(size: 16, weight: .bold))
                            .padding(.top, 2)
                        Text(item)
                            .font(.system(size: 15, weight: .medium))
                            .foregroundStyle(Color.white.opacity(0.9))
                    }
                }
            }
        }
        .objectsCard()
    }

    var capabilitiesCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionTitle("Технологические возможности")

            VStack(spacing: 14) {
                ForEach(building.technologyCapabilities) { capability in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(alignment: .center, spacing: 10) {
                            Text(capability.title)
                                .font(.system(size: 16, weight: .semibold))
                            Spacer()
                            ObjectsPill(text: capability.status.title, background: statusColor(for: capability.status))
                        }

                        Text(capability.details)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(Color.white.opacity(0.7))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(14)
                    .background(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .fill(Color.theme.primaryColor.opacity(0.8))
                            .overlay(
                                RoundedRectangle(cornerRadius: 18, style: .continuous)
                                    .stroke(Color.white.opacity(0.05), lineWidth: 1)
                            )
                    )
                }
            }
        }
        .objectsCard()
    }

    var apartmentsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionTitle("Подключённые квартиры")

            VStack(spacing: 14) {
                ForEach(building.apartments) { apartment in
                    NavigationLink(value: ObjectDestination.apartment(apartment)) {
                        HStack(spacing: 16) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Квартира \(apartment.number)")
                                    .font(.system(size: 17, weight: .semibold))

                                Text("Лицевой счёт \(apartment.accountNumber)")
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundStyle(Color.white.opacity(0.65))
                            }

                            Spacer()

                            VStack(alignment: .trailing, spacing: 6) {
                                ForEach(apartment.connectedServices.prefix(2), id: \.self) { service in
                                    ObjectsPill(text: service, foreground: Color.white.opacity(0.9), background: Color.theme.primaryColor.opacity(0.6))
                                }

                                if apartment.connectedServices.count > 2 {
                                    Text("+\(apartment.connectedServices.count - 2) ещё")
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundStyle(Color.white.opacity(0.5))
                                }
                            }
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
            }
        }
        .objectsCard()
    }
}

// MARK: - Helpers

private extension ObjectDetailView {
    func sectionTitle(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 18, weight: .semibold))
    }

    func infoRow(icon: String, title: String, value: String) -> some View {
        HStack(alignment: .center, spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .semibold))
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

    func statusColor(for status: ObjectTechnologyStatus) -> Color {
        switch status {
        case .ready:
            return Color.green.opacity(0.65)
        case .requiresPreparation:
            return Color.orange.opacity(0.7)
        case .unavailable:
            return Color.red.opacity(0.6)
        }
    }
}
