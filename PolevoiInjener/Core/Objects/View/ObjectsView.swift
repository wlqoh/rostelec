//
//  ObjectsView.swift
//  PolevoiInjener
//
//  Created by Мурад on 30/10/25.
//

import SwiftUI

struct ObjectsView: View {
    @State private var viewMode: ObjectsViewMode = .list
    @State private var searchText: String = ""

    private let buildings: [Building] = [
        .init(
            id: "1",
            type: "МКД",
            status: "В работе",
            address: "ул. Пушкина, д. 12",
            city: "Москва",
            district: "Центральный",
            distance: "3.2 км",
            visits: 45
        ),
        .init(
            id: "2",
            type: "Бизнес-центр",
            status: "Новый",
            address: "пр-т Ленина, д. 50",
            city: "Москва",
            district: "Северный",
            distance: "5.4 км",
            visits: 0
        ),
        .init(
            id: "3",
            type: "ТЦ",
            status: "Завершён",
            address: "Торговый комплекс \"Галерея\"",
            city: "Санкт-Петербург",
            district: "Приморский",
            distance: "4.8 км",
            visits: 120
        )
    ]

    private var filteredBuildings: [Building] {
        guard !searchText.isEmpty else { return buildings }
        return buildings.filter {
            $0.address.lowercased().contains(searchText.lowercased()) ||
            $0.city.lowercased().contains(searchText.lowercased())
        }
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color.theme.backgroundColor
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    header
                    viewToggle
                    searchField

                    switch viewMode {
                    case .list:
                        if filteredBuildings.isEmpty {
                            ObjectsEmptyState()
                        } else {
                            VStack(spacing: 16) {
                                ForEach(filteredBuildings) { building in
                                    ObjectsCard(building: building)
                                }
                            }
                        }

                    case .map:
                        ObjectsMapPlaceholder()
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 52)
                .padding(.bottom, 120)
            }

            addButton
                .padding(.trailing, 24)
                .padding(.bottom, 40)
        }
    }

    private var header: some View {
        Text("Объекты")
            .font(.system(size: 34, weight: .bold))
    }

    private var viewToggle: some View {
        HStack(spacing: 12) {
            ObjectsToggleButton(
                title: "Список",
                systemImage: "list.bullet",
                isSelected: viewMode == .list,
                action: { viewMode = .list }
            )

            ObjectsToggleButton(
                title: "Карта",
                systemImage: "map",
                isSelected: viewMode == .map,
                action: { viewMode = .map }
            )
        }
    }

    private var searchField: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color.white.opacity(0.6))

            TextField("Поиск по адресу...", text: $searchText)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.theme.primaryColor.opacity(0.8))
                .overlay(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(Color.white.opacity(0.05), lineWidth: 1)
                )
        )
    }

    private var addButton: some View {
        Button(action: {}) {
            Image(systemName: "plus")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.white)
                .frame(width: 62, height: 62)
                .background(
                    Circle()
                        .fill(Color.theme.secondaryColor)
                )
                .shadow(color: Color.theme.secondaryColor.opacity(0.5), radius: 24, x: 0, y: 12)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ObjectsView()
}

private enum ObjectsViewMode {
    case list
    case map
}

private struct Building: Identifiable {
    let id: String
    let type: String
    let status: String
    let address: String
    let city: String
    let district: String
    let distance: String
    let visits: Int
}

private struct ObjectsToggleButton: View {
    let title: String
    let systemImage: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: systemImage)
                    .font(.system(size: 15, weight: .semibold))
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
            }
            .foregroundStyle(isSelected ? Color.white : Color.white.opacity(0.75))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(isSelected ? Color.theme.secondaryColor : Color.theme.primaryColor.opacity(0.65))
            )
        }
        .buttonStyle(.plain)
    }
}

private struct ObjectsCard: View {
    let building: Building

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 8) {
                        Text(building.type)
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(
                                Capsule(style: .continuous)
                                    .fill(Color.white.opacity(0.12))
                            )

                        Text(building.status)
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(
                                Capsule(style: .continuous)
                                    .fill(Color.theme.secondaryColor)
                            )
                    }

                    Text(building.address)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.white)

                    Text("\(building.city) • \(building.district)")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(Color.white.opacity(0.65))
                }

                Spacer()
            }

            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Label {
                        Text("Расстояние:")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundStyle(Color.white.opacity(0.65))
                    } icon: {
                        Image(systemName: "location.north.line")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(Color.theme.secondaryColor)
                    }

                    Spacer()

                    Text(building.distance)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.white)
                }

                HStack {
                    Text("Визитов:")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(Color.white.opacity(0.65))

                    Spacer()

                    Text("\(building.visits)")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.white)
                }
            }

            Button(action: {}) {
                HStack {
                    Image(systemName: "play.fill")
                        .font(.system(size: 15, weight: .bold))
                    Text("Старт визита")
                        .font(.system(size: 16, weight: .semibold))
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(Color.theme.secondaryColor)
                )
            }
            .buttonStyle(.plain)
        }
        .padding(22)
        .background(
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .fill(Color.theme.primaryColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 26, style: .continuous)
                        .stroke(Color.white.opacity(0.05), lineWidth: 1)
                )
        )
    }
}

private struct ObjectsMapPlaceholder: View {
    var body: some View {
        VStack(spacing: 18) {
            Image(systemName: "map")
                .font(.system(size: 48, weight: .semibold))
                .foregroundStyle(Color.white.opacity(0.45))

            Text("Карта с текущей локацией")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.white)

            Text("(заглушка)")
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(Color.white.opacity(0.55))
        }
        .frame(maxWidth: .infinity)
        .frame(height: 320)
        .background(
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .fill(Color.theme.primaryColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 26, style: .continuous)
                        .stroke(Color.white.opacity(0.05), lineWidth: 1)
                )
        )
    }
}

private struct ObjectsEmptyState: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "building.2.crop.circle")
                .font(.system(size: 34, weight: .semibold))
                .foregroundStyle(Color.white.opacity(0.45))

            Text("Нет объектов по запросу")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.white)

            Text("Попробуйте изменить поисковый запрос или сбросить фильтры.")
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(Color.white.opacity(0.55))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 38)
        .padding(.horizontal, 20)
        .background(
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .fill(Color.theme.primaryColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 26, style: .continuous)
                        .stroke(Color.white.opacity(0.05), lineWidth: 1)
                )
        )
    }
}
