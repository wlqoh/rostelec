//
//  ProfileView.swift
//  PolevoiInjener
//
//  Created by Мурад on 30/10/25.
//

import SwiftUI

struct RouteView: View {
    private let tasks: [RouteTask] = [
        .init(
            id: UUID(),
            type: "МКД",
            address: "ул. Пушкина, д. 12",
            city: "Москва",
            area: "Центральный",
            timeRange: "10:00 - 12:00",
            responsible: "Иванов И.И.",
            status: "В работе"
        )
    ]

    private var stats: [RouteStat] {
        [
            .init(title: "Задач", value: "\(tasks.count)", accent: Color.theme.secondaryColor),
            .init(title: "Выполнено", value: "2", accent: Color.theme.secondaryColor.opacity(0.85)),
            .init(title: "Осталось", value: "1", accent: Color.theme.secondaryColor.opacity(0.65))
        ]
    }

    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    header

                    statsRow

                    Text("Задачи на сегодня")
                        .font(.system(size: 20, weight: .semibold))
                        .padding(.top, 4)

                    if tasks.isEmpty {
                        RouteEmptyState()
                    } else {
                        VStack(spacing: 14) {
                            ForEach(tasks) { task in
                                RouteTaskCard(task: task)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 52)
                .padding(.bottom, 140)
            }
        }
    }

    private var header: some View {
        HStack(alignment: .center) {
            Text("Сегодня")
                .font(.system(size: 34, weight: .bold))

            Spacer()

            HStack(spacing: 20) {
                HeaderButton(icon: "arrow.triangle.2.circlepath")
                HeaderButton(icon: "bell")
            }
        }
    }

    private var statsRow: some View {
        HStack(spacing: 14) {
            ForEach(stats) { stat in
                RouteStatCard(stat: stat)
            }
        }
    }
}

private struct HeaderButton: View {
    let icon: String

    var body: some View {
        Button(action: {}) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .semibold))
                .frame(width: 34, height: 34)
                
        }
    }
}

private struct RouteStat: Identifiable {
    let id = UUID()
    let title: String
    let value: String
    let accent: Color
}

private struct RouteTask: Identifiable {
    let id: UUID
    let type: String
    let address: String
    let city: String
    let area: String
    let timeRange: String
    let responsible: String
    let status: String
}

private struct RouteStatCard: View {
    let stat: RouteStat

    var body: some View {
        VStack(alignment: .center, spacing: 1) {
            Text(stat.value)
                .font(.system(size: 26, weight: .bold))
                .foregroundStyle(stat.accent)

            Text(stat.title)
                .font(.system(size: 14, weight: .medium))
                
        }
        .padding(.vertical, 18)
        .padding(.horizontal, 2)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.theme.primaryColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(Color.white.opacity(0.06), lineWidth: 1)
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.theme.backgroundColor.opacity(0.35), lineWidth: 1)
        )
    }
}

private struct RouteTaskCard: View {
    let task: RouteTask

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Text(task.type)
                    .font(.system(size: 14, weight: .semibold))
                    .padding(.horizontal, 14)
                    .padding(.vertical, 6)
                    .background(
                        Capsule(style: .continuous)
                            .fill(Color.white.opacity(0.12))
                    )

                Spacer()

                Text(task.status)
                    .font(.system(size: 14, weight: .semibold))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 6)
                    .background(
                        Capsule(style: .continuous)
                            .fill(Color.theme.secondaryColor)
                    )
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(task.address)
                    .font(.system(size: 20, weight: .semibold))

                Text("\(task.city) • \(task.area)")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(Color.white.opacity(0.65))
            }

            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .top) {
                    Text("Планируемое время:")
                        .foregroundStyle(Color.white.opacity(0.65))
                    Spacer()
                    Text(task.timeRange)
                }

                HStack(alignment: .top) {
                    Text("Ответственный:")
                        .foregroundStyle(Color.white.opacity(0.65))
                    Spacer()
                    Text(task.responsible)
                }
            }
            .font(.system(size: 15, weight: .medium))
//            .foregroundStyle(Color.white.opacity(0.65))

            Button(action: {}) {
                HStack {
                    Image(systemName: "play.fill")
                        .font(.system(size: 16, weight: .bold))
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
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.theme.backgroundColor.opacity(0.25), lineWidth: 1)
        )
    }
}

private struct RouteEmptyState: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "checkmark.circle")
                .font(.system(size: 32, weight: .semibold))
                .foregroundStyle(Color.white.opacity(0.45))

            Text("Нет задач на сегодня")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Color.white)

            Text("Как только появятся новые задачи, они сразу же появятся здесь.")
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

#Preview {
    RouteView()
        .preferredColorScheme(.dark)
}
