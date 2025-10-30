//
//  ListView.swift
//  PolevoiInjener
//
//  Created by Мурад on 30/10/25.
//

import SwiftUI

struct ProfileView: View {
    @State private var searchText: String = ""
    private var items: [Item] = [
        .init(name: "Москва"),
        .init(name: "Махачкала"),
        .init(name: "Каспийск"),
        .init(name: "АВА"),
        .init(name: "ываыва"),
        .init(name: "жддддд"),
    ]
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(items.filter { searchText.isEmpty || $0.name.localizedStandardContains(searchText) }, id: \.self) { item in
                        NavigationLink {
                            Text("sdfdsfdsf")
                        } label: {
                            Text("\(item.name)")
                        }
                        
                    }
                }
                .searchable(text: $searchText, placement: .navigationBarDrawer, prompt: "Введите название города")
            }
            .navigationTitle(Text("SDF"))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        Text("Гамид чорт")
                    } label: {
                        Text("SDFSDF")
                    }
                }
            }
        }
            
    }
}

struct Item: Identifiable, Hashable {
    var id = UUID().uuidString
    var name: String
}
#Preview {
    ProfileView()
}
