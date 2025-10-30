//
//  AuthView.swift
//  PolevoiInjener
//
//  Created by Мурад on 31/10/25.
//

import SwiftUI

struct AuthView: View {
    @State private var login: String = ""
    @State private var password: String = ""
    @State private var selectedLocation: Location = .makhachkala

    private var isFormValid: Bool {
        !login.trimmingCharacters(in: .whitespaces).isEmpty &&
        !password.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 32) {
                    header
                    formCard
                    footer
                }
                .padding(.horizontal, 24)
                .padding(.top, 80)
                .padding(.bottom, 40)
            }
        }
    }
}

private extension AuthView {
    var header: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("С возвращением!")
                .font(.system(size: 34, weight: .bold))
                .foregroundStyle(.white)

            Text("Введите данные для входа и выберите регион работы.")
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(Color.white.opacity(0.65))
        }
    }

    var formCard: some View {
        VStack(alignment: .leading, spacing: 22) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Логин")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(Color.white.opacity(0.7))

                AuthTextField(
                    text: $login,
                    placeholder: "Введите логин",
                    icon: "person.fill",
                    isSecure: false
                )
            }

            VStack(alignment: .leading, spacing: 10) {
                Text("Пароль")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(Color.white.opacity(0.7))

                AuthTextField(
                    text: $password,
                    placeholder: "Введите пароль",
                    icon: "lock.fill",
                    isSecure: true
                )
            }

            VStack(alignment: .leading, spacing: 10) {
                Text("Регион")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(Color.white.opacity(0.7))

                Menu {
                    ForEach(Location.allCases) { location in
                        Button(location.title) {
                            selectedLocation = location
                        }
                    }
                } label: {
                    HStack {
                        Label(selectedLocation.title, systemImage: "mappin.circle.fill")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.white)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(Color.white.opacity(0.6))
                    }
                    .padding(.horizontal, 18)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity, minHeight: 54)
                    .background(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .fill(Color.white.opacity(0.06))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .stroke(Color.white.opacity(0.08), lineWidth: 1)
                    )
                }
                .menuStyle(.automatic)
            }

            Button(action: submit) {
                HStack {
                    Spacer()
                    Text("Войти")
                        .font(.system(size: 17, weight: .semibold))
                    Spacer()
                }
                .foregroundStyle(.white)
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(isFormValid ? Color.theme.secondaryColor : Color.white.opacity(0.12))
                )
            }
            .disabled(!isFormValid)
            .buttonStyle(.plain)
        }
        .padding(26)
        .background(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(Color.theme.primaryColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                        .stroke(Color.white.opacity(0.05), lineWidth: 1)
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 28)
                .stroke(Color.theme.backgroundColor.opacity(0.35), lineWidth: 1)
        )
    }

    var footer: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Техническая поддержка")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(.white)

            Text("При возникновении ошибок обратитесь в службу сопровождения по телефону +7 (800) 123-45-67.")
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(Color.white.opacity(0.55))
        }
    }

    func submit() {
        guard isFormValid else { return }
        // TODO: Integrate with auth flow once available.
    }

    enum Location: String, CaseIterable, Identifiable {
        case makhachkala = "Махачкала"
        case kaspiysk = "Каспийск"
        case chechnya = "Чечня"

        var id: String { rawValue }

        var title: String { rawValue }
    }
}

private struct AuthTextField: View {
    @Binding var text: String
    let placeholder: String
    let icon: String
    let isSecure: Bool

    @State private var isSecureEntry: Bool

    init(text: Binding<String>, placeholder: String, icon: String, isSecure: Bool) {
        _text = text
        self.placeholder = placeholder
        self.icon = icon
        self.isSecure = isSecure
        _isSecureEntry = State(initialValue: isSecure)
    }

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(Color.white.opacity(0.65))

            Group {
                if isSecure, isSecureEntry {
                    SecureField(placeholder, text: $text)
                        .foregroundStyle(.white)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                } else if isSecure {
                    TextField(placeholder, text: $text)
                        .foregroundStyle(.white)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                } else {
                    TextField(placeholder, text: $text)
                        .foregroundStyle(.white)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
            }
            .font(.system(size: 16, weight: .medium))

            if isSecure {
                Button(action: toggleSecureEntry) {
                    Image(systemName: isSecureEntry ? "eye.slash.fill" : "eye.fill")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Color.white.opacity(0.6))
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity, minHeight: 54)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color.white.opacity(0.06))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(Color.white.opacity(0.08), lineWidth: 1)
        )
    }

    private func toggleSecureEntry() {
        isSecureEntry.toggle()
    }
}

#Preview {
    AuthView()
        .preferredColorScheme(.dark)
}
