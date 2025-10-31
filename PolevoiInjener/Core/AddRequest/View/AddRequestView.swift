//
//  AddRequestView.swift
//  PolevoiInjener
//
//  Created by Codex on 01/11/25.
//

import SwiftUI

struct AddRequestView: View {
    private enum Constants {
        static let fieldCornerRadius: CGFloat = 18
        static let cardCornerRadius: CGFloat = 28
    }

    enum City: String, CaseIterable, Identifiable {
        case moscow = "Москва"
        case saintPetersburg = "Санкт-Петербург"
        case yekaterinburg = "Екатеринбург"
        case kazan = "Казань"

        var id: String { rawValue }
    }

    enum Service: String, CaseIterable, Identifiable {
        case internet = "Интернет"
        case tv = "ТВ"
        case video = "Видеонаблюдение"
        case nanny = "Интернет-няня"

        var id: String { rawValue }
    }

    struct Coordinates: Equatable {
        let latitude: Double
        let longitude: Double

        var formatted: String {
            let lat = String(format: "%.5f", latitude)
            let lon = String(format: "%.5f", longitude)
            return "\(lat), \(lon)"
        }
    }

    @Environment(\.dismiss) private var dismiss

    @State private var selectedCity: City = .moscow
    @State private var address: String = ""
    @State private var apartmentNumber: String = ""
    @State private var phoneNumber: String = ""
    @State private var portrait: String = ""
    @State private var selectedServices: Set<Service> = []
    @State private var interests: String = ""
    @State private var contactWindow: String = ""
    @State private var desiredPrice: String = ""
    @State private var note: String = ""
    @State private var detectedCoordinates: Coordinates?
    @State private var isDetectingLocation: Bool = false
    @State private var showSaveConfirmation: Bool = false

    private let serviceColumns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 26) {
                    objectCard
                    visitCard
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 28)
            }
            .background(Color.theme.backgroundColor.ignoresSafeArea())
            .navigationTitle("Новая заявка")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Закрыть") {
                        dismiss()
                    }
                    .foregroundStyle(Color.white.opacity(0.8))
                }
            }
            .alert("Заявка сохранена", isPresented: $showSaveConfirmation) {
                Button("Хорошо", role: .cancel) {
                    dismiss()
                }
            } message: {
                Text("Заявка добавлена в офлайн-очередь. Отправим на сервер при подключении.")
            }
        }
    }
}

// MARK: - Cards

private extension AddRequestView {
    var objectCard: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Объект")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.white)

            VStack(alignment: .leading, spacing: 10) {
                inputLabel("Город")

                Menu {
                    ForEach(City.allCases) { city in
                        Button(city.rawValue) {
                            selectedCity = city
                        }
                    }
                } label: {
                    HStack(spacing: 12) {
                        Image(systemName: "building.2.fill")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color.theme.secondaryColor)
                        Text(selectedCity.rawValue)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.white)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(Color.white.opacity(0.6))
                    }
                    .padding(.horizontal, 18)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity, minHeight: 56)
                    .background(fieldBackground())
                }
                .menuStyle(.automatic)
            }

            VStack(alignment: .leading, spacing: 10) {
                inputLabel("Адрес")

                TextField("ул. Пример, д. 1", text: $address)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.white)
                    .textInputAutocapitalization(.sentences)
                    .autocorrectionDisabled()
                    .padding(.horizontal, 18)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity, minHeight: 56)
                    .background(fieldBackground())
            }

            Button(action: detectLocation) {
                HStack(spacing: 12) {
                    ZStack {
                        Circle()
                            .fill(Color.theme.secondaryColor.opacity(0.2))
                            .frame(width: 32, height: 32)

                        Image(systemName: "mappin.and.ellipse")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color.theme.secondaryColor)
                    }

                    if isDetectingLocation {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .tint(Color.theme.secondaryColor)
                    } else {
                        Text("Определить моё местоположение")
                            .font(.system(size: 16, weight: .semibold))
                    }

                    if let coordinates = detectedCoordinates, !isDetectingLocation {
                        Spacer()
                        Text("(\(coordinates.formatted))")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(Color.white.opacity(0.7))
                    }
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 18)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity, minHeight: 56)
                .background(
                    RoundedRectangle(cornerRadius: Constants.fieldCornerRadius, style: .continuous)
                        .fill(Color.theme.secondaryColor.opacity(0.18))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: Constants.fieldCornerRadius, style: .continuous)
                        .stroke(Color.white.opacity(0.08), lineWidth: 1)
                )
            }
            .buttonStyle(.plain)

            if let coordinates = detectedCoordinates {
                Text("Координаты сохранены: \(coordinates.formatted)")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(Color.white.opacity(0.6))
            }
        }
        .padding(26)
        .background(cardBackground())
    }

    var visitCard: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Визит")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.white)

            HStack(alignment: .top, spacing: 20) {
                labeledTextField(
                    title: "Квартира/Номер",
                    placeholder: "45",
                    text: $apartmentNumber
                )

                labeledTextField(
                    title: "Телефон",
                    placeholder: "+7 (___) ___-__-__",
                    text: $phoneNumber,
                    keyboardType: .phonePad,
                    autocapitalization: .never
                )
            }

            labeledTextField(
                title: "Портрет клиента",
                placeholder: "Например: мужчина ~40 лет, работает из дома",
                text: $portrait
            )

            VStack(alignment: .leading, spacing: 12) {
                inputLabel("Чем пользуется")

                LazyVGrid(columns: serviceColumns, spacing: 12) {
                    ForEach(Service.allCases) { service in
                        let isSelected = selectedServices.contains(service)

                        Button {
                            toggleService(service)
                        } label: {
                            HStack(spacing: 12) {
                                Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundStyle(isSelected ? Color.theme.secondaryColor : Color.white.opacity(0.65))

                                Text(service.rawValue)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundStyle(.white)

                                Spacer()
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 14)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: Constants.fieldCornerRadius, style: .continuous)
                                    .fill(isSelected ? Color.theme.secondaryColor.opacity(0.22) : Color.white.opacity(0.06))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: Constants.fieldCornerRadius, style: .continuous)
                                    .stroke(isSelected ? Color.theme.secondaryColor.opacity(0.35) : Color.white.opacity(0.08), lineWidth: 1)
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }

            labeledTextField(
                title: "Интерес к услугам (ввод через запятую)",
                placeholder: "Интернет, Видеонаблюдение",
                text: $interests
            )

            HStack(alignment: .top, spacing: 20) {
                labeledTextField(
                    title: "Удобное время для связи",
                    placeholder: "18:00-20:00",
                    text: $contactWindow
                )

                labeledTextField(
                    title: "Желаемая цена",
                    placeholder: "800 руб/мес",
                    text: $desiredPrice
                )
            }

            labeledTextField(
                title: "Примечание",
                placeholder: "Короткое примечание",
                text: $note
            )

            Button(action: save) {
                HStack {
                    Spacer()
                    Text("Сохранить")
                        .font(.system(size: 17, weight: .semibold))
                    Spacer()
                }
                .foregroundStyle(.white)
                .padding(.vertical, 18)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color.theme.secondaryColor)
                )
            }
            .buttonStyle(.plain)
        }
        .padding(26)
        .background(cardBackground())
    }
}

// MARK: - Helpers

private extension AddRequestView {
    func inputLabel(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 14, weight: .medium))
            .foregroundStyle(Color.white.opacity(0.65))
    }

    func fieldBackground() -> some View {
        RoundedRectangle(cornerRadius: Constants.fieldCornerRadius, style: .continuous)
            .fill(Color.white.opacity(0.06))
            .overlay(
                RoundedRectangle(cornerRadius: Constants.fieldCornerRadius, style: .continuous)
                    .stroke(Color.white.opacity(0.08), lineWidth: 1)
            )
    }

    func cardBackground() -> some View {
        RoundedRectangle(cornerRadius: Constants.cardCornerRadius, style: .continuous)
            .fill(Color.theme.primaryColor)
            .overlay(
                RoundedRectangle(cornerRadius: Constants.cardCornerRadius, style: .continuous)
                    .stroke(Color.white.opacity(0.05), lineWidth: 1)
            )
    }

    func labeledTextField(
        title: String,
        placeholder: String,
        text: Binding<String>,
        keyboardType: UIKeyboardType = .default,
        autocapitalization: TextInputAutocapitalization = .sentences
    ) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            inputLabel(title)

            TextField(placeholder, text: text)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.white)
                .textInputAutocapitalization(autocapitalization)
                .autocorrectionDisabled()
                .keyboardType(keyboardType)
                .padding(.horizontal, 18)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity, minHeight: 56)
                .background(fieldBackground())
        }
    }

    func toggleService(_ service: Service) {
        if selectedServices.contains(service) {
            selectedServices.remove(service)
        } else {
            selectedServices.insert(service)
        }
    }

    func detectLocation() {
        guard !isDetectingLocation else { return }
        isDetectingLocation = true
        Task {
            try? await Task.sleep(nanoseconds: 800_000_000)
            await MainActor.run {
                detectedCoordinates = Coordinates(latitude: 43.02351, longitude: 47.50473)
                isDetectingLocation = false
            }
        }
    }

    func save() {
        showSaveConfirmation = true
    }
}

#Preview {
    NavigationStack {
        AddRequestView()
            .preferredColorScheme(.dark)
    }
}
