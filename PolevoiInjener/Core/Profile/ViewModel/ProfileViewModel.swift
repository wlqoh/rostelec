//
//  ProfileViewModel.swift
//  PolevoiInjener
//
//  Created by Мурад on 31/10/25.
//

//import SwiftUI
//import Combine
//
//@MainActor
//final class ProfileViewModel: ObservableObject {
//    @Published var data: [ModelCard] = [
//        .init(cityId: "1", districtId: "2", status: .DONE, search: "SDFSDFDSF", page: 1, limit: 20)
//    ]
//
//    private var timerTask: Task<Void, Never>? = nil
//    private let repository = Repo()  // ваш слой сети
//
//    func startAutoRefresh() {
//        timerTask = Task {
//            for await _ in Timer.publish(every: 5, on: .main, in: .common).autoconnect().values {
//                await loadData()
//            }
//        }
//    }
//
//    func stopAutoRefresh() {
//        timerTask?.cancel()
//        timerTask = nil
//    }
//
//    func loadData() async {
//        do {
//            let response = try await repository.loadItems()
////            data = response
//        } catch {
//            print("Ошибка загрузки: \(error)")
//        }
//    }
//}
