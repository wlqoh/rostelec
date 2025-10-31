//
//  ObjectsView.swift
//  PolevoiInjener
//
//  Created by Мурад on 30/10/25.
//

import SwiftUI
import MapKit

struct ObjectsView: View {
    @State private var viewMode: ObjectsViewMode = .list
    @State private var searchText: String = ""
    @State private var path: [ObjectDestination] = []

    private let buildings: [ObjectBuilding] = ObjectMockData.buildings

    private var filteredBuildings: [ObjectBuilding] {
        guard !searchText.isEmpty else { return buildings }
        return buildings.filter {
            $0.address.lowercased().contains(searchText.lowercased()) ||
            $0.city.lowercased().contains(searchText.lowercased()) ||
            $0.district.lowercased().contains(searchText.lowercased())
        }
    }

    var body: some View {
        NavigationStack(path: $path) {
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
                                        NavigationLink(value: ObjectDestination.building(building)) {
                                            ObjectsBuildingCard(building: building)
                                        }
                                        .buttonStyle(.plain)
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
            .navigationDestination(for: ObjectDestination.self) { destination in
                switch destination {
                case .building(let building):
                    ObjectDetailView(building: building)
                case .apartment(let apartment):
                    ApartmentDetailView(apartment: apartment)
                case .client(let client):
                    ClientDetailView(client: client)
                }
            }
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
        .preferredColorScheme(.dark)
}

private enum ObjectsViewMode {
    case list
    case map
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

private struct ObjectsBuildingCard: View {
    let building: ObjectBuilding

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(spacing: 8) {
                ObjectsPill(
                    text: building.type,
                    foreground: Color.white.opacity(0.9),
                    background: Color.white.opacity(0.12)
                )
                ObjectsPill(
                    text: building.status,
                    foreground: .white,
                    background: Color.theme.secondaryColor
                )
                ObjectsPill(
                    text: building.connectionType.rawValue,
                    foreground: Color.white.opacity(0.9),
                    background: Color.theme.primaryColor.opacity(0.6)
                )
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(building.address)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.white)

                Text("\(building.city) • \(building.district)")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(Color.white.opacity(0.65))
            }

            Divider()
                .overlay(Color.white.opacity(0.05))

            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Label {
                        Text("Расстояние")
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
                    Text("Последних визитов")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(Color.white.opacity(0.65))

                    Spacer()

                    Text("\(building.visits)")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.white)
                }
            }

            if !building.apartments.isEmpty {
                Divider()
                    .overlay(Color.white.opacity(0.05))

                VStack(alignment: .leading, spacing: 12) {
                    Text("Подключённые квартиры")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(Color.white.opacity(0.65))

                    ForEach(building.apartments.prefix(2)) { apartment in
                        HStack(alignment: .top, spacing: 12) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Квартира \(apartment.number)")
                                    .font(.system(size: 15, weight: .semibold))
                                Text("Лицевой счёт \(apartment.accountNumber)")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundStyle(Color.white.opacity(0.6))
                            }

                            Spacer()

                            if let firstService = apartment.connectedServices.first {
                                ObjectsPill(
                                    text: firstService,
                                    foreground: Color.white.opacity(0.9),
                                    background: Color.theme.primaryColor.opacity(0.55)
                                )
                            }
                        }
                    }

                    if building.apartments.count > 2 {
                        Text("+ ещё \(building.apartments.count - 2)")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(Color.white.opacity(0.5))
                    }
                }
            }
        }
        .objectsCard()
    }
}

private struct ObjectsMapPlaceholder: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 42.9849, longitude: 47.5047),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    var body: some View {
        Map(coordinateRegion: $region)
            .frame(maxWidth: .infinity)
            .frame(height: 500)
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
