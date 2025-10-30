//
//  ProfileView.swift
//  PolevoiInjener
//
//  Created by Мурад on 30/10/25.
//

import SwiftUI

struct RouteView: View {
    private let stats: [RouteStat] = [
        .init(title: "Задач", value: "1", accent: Color.theme.violetAccent),
        .init(title: "Выполнено", value: "2", accent: Color.theme.greenAccent),
        .init(title: "Осталось", value: "1", accent: Color.theme.amberAccent)
    ]

    private let task: RouteTask = .init(
        type: "МКД",
        address: "ул. Пушкина, д. 12",
        city: "Москва",
        area: "Центральный",
        timeRange: "10:00 - 12:00",
        responsible: "Иванов И.И.",
        status: "В работе"
    )

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
                        .foregroundStyle(.white)
                        .padding(.top, 4)

                    RouteTaskCard(task: task)
                }
                .padding(.horizontal, 20)
                .padding(.top, 32)
                .padding(.bottom, 140)
            }
        }
    }

    private var header: some View {
        HStack(alignment: .center) {
            Text("Сегодня")
                .font(.system(size: 34, weight: .bold))
                .foregroundStyle(.white)

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
                .foregroundStyle(Color.white.opacity(0.8))
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

private struct RouteTask {
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
        VStack(alignment: .leading, spacing: 6) {
            Text(stat.value)
                .font(.system(size: 26, weight: .bold))
                .foregroundStyle(stat.accent)

            Text(stat.title)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(Color.white.opacity(0.7))
        }
        .padding(.vertical, 18)
        .padding(.horizontal, 22)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.theme.surfaceColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(Color.white.opacity(0.06), lineWidth: 1)
                )
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
                    .foregroundStyle(.white)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 6)
                    .background(
                        Capsule(style: .continuous)
                            .fill(Color.white.opacity(0.12))
                    )

                Spacer()

                Text(task.status)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.white)
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
                    .foregroundStyle(.white)

                Text("\(task.city) • \(task.area)")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(Color.white.opacity(0.65))
            }

            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .top) {
                    Text("Планируемое время:")
                    Spacer()
                    Text(task.timeRange)
                        .foregroundStyle(.white)
                }

                HStack(alignment: .top) {
                    Text("Ответственный:")
                    Spacer()
                    Text(task.responsible)
                        .foregroundStyle(.white)
                }
            }
            .font(.system(size: 15, weight: .medium))
            .foregroundStyle(Color.white.opacity(0.65))

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
                .fill(Color.theme.elevatedSurfaceColor)
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
