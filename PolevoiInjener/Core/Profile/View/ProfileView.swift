//
//  ProfileView.swift
//  PolevoiInjener
//
//  Created by Codex on 31/10/25.
//

import SwiftUI

struct ProfileView: View {
    @State private var startView: StartView = .list
    @State private var isGPSEnabled: Bool = true
    @State private var isCameraEnabled: Bool = false
    @State private var isNotificationsEnabled: Bool = true

    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 28) {
                    header
                    profileCard
                    syncSection
                    settingsSection
                    logoutButton
                }
                .padding(.horizontal, 20)
                .padding(.top, 52)
                .padding(.bottom, 150)
            }
        }
    }

    private var header: some View {
        Text("Профиль")
            .font(.system(size: 34, weight: .bold))
            .foregroundStyle(.white)
    }

    private var profileCard: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(alignment: .center, spacing: 18) {
                Circle()
                    .fill(Color.theme.secondaryColor)
                    .frame(width: 68, height: 68)
                    .overlay(
                        Text("ИИ")
                            .font(.system(size: 26, weight: .bold))
                            .foregroundStyle(Color.white)
                    )

                VStack(alignment: .leading, spacing: 8) {
                    Text("Иванов Иван Иванович")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.white)

                    Text("Инженер")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(Color.white.opacity(0.75))

                    HStack(spacing: 6) {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(Color.theme.secondaryColor)
                        Text("Москва • Центральный район")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(Color.white.opacity(0.7))
                    }
                }

                Spacer()
            }
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .fill(Color.theme.primaryColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 26, style: .continuous)
                        .stroke(Color.white.opacity(0.05), lineWidth: 1)
                )
        )
    }

    private var syncSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Состояние синхронизации")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.white)

            VStack(alignment: .leading, spacing: 18) {
                HStack {
                    Text("Статус:")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(Color.white.opacity(0.7))

                    Spacer()

                    Label("Онлайн", systemImage: "dot.radiowaves.left.and.right")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(Color.theme.secondaryColor)
                }

                HStack(spacing: 14) {
                    ProfileSyncMetricView(title: "На устройстве", value: "3")
                    ProfileSyncMetricView(title: "В очереди", value: "1")
                    ProfileSyncMetricView(title: "Отправлено", value: "45")
                }
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

    private var settingsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Настройки")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.white)

            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Стартовый вид")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(Color.white.opacity(0.7))

                    Picker("", selection: $startView) {
                        ForEach(StartView.allCases) { view in
                            Text(view.title)
                                .tag(view)
                        }
                    }
                    .pickerStyle(.segmented)
                    .tint(Color.theme.secondaryColor)
                }

                ProfileToggleRow(
                    title: "GPS",
                    isOn: $isGPSEnabled
                )

                ProfileToggleRow(
                    title: "Камера",
                    isOn: $isCameraEnabled
                )

                ProfileToggleRow(
                    title: "Уведомления",
                    isOn: $isNotificationsEnabled
                )
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

    private var logoutButton: some View {
        Button(action: {}) {
            Text("Выйти")
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(Color.theme.secondaryColor)
                )
        }
        .buttonStyle(.plain)
    }
}

private enum StartView: String, CaseIterable, Identifiable {
    case list
    case map

    var id: String { rawValue }

    var title: String {
        switch self {
        case .list:
            return "Список"
        case .map:
            return "Карта"
        }
    }
}

private struct ProfileSyncMetricView: View {
    let title: String
    let value: String

    var body: some View {
        VStack(spacing: 6) {
            Text(value)
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(Color.theme.secondaryColor)

            Text(title)
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(Color.white.opacity(0.7))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .padding(.horizontal, 4)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color.theme.backgroundColor.opacity(0.35))
        )
    }
}

private struct ProfileToggleRow: View {
    let title: String
    @Binding var isOn: Bool

    var body: some View {
        Toggle(isOn: $isOn) {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.white)
        }
        .tint(Color.theme.secondaryColor)
    }
}

#Preview {
    ProfileView()
        .preferredColorScheme(.dark)
}
