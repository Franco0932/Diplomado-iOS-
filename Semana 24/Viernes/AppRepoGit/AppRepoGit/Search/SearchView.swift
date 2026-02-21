//
//  SearchView.swift
//  AppRepoGit
//
//  Created by Franco Ruiz on 20/02/26.
//

import SwiftUI

struct DevSearchView: View {
    @StateObject private var searchViewModel = SearchViewModel()
    
    var body: some View {
        ZStack {
            Color.VIEW_BACKG
                .ignoresSafeArea()
            
            VStack(spacing: 52) {
                VStack(spacing: 16) {
                    ZStack {
                        Circle().fill(.carBackground)
                            .frame(width: 100, height: 100)
                        
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(.BLUE)
                    }
                    
                    VStack(spacing: 8) {
                        Text("Encuentra a alguien")
                            .font(.title).bold()
                        Text("Busca desarrolladores por su nombre de usuario")
                    }
                }
                                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Usuario")
                    TextField("Escribe el nombre de usuario aquí ...", text: $searchViewModel.searchText)
                        .padding()
                        .foregroundStyle(.sectext)
                        .background(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(.white)
                        )
                        .overlay {
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .stroke(.border, lineWidth: 1)
                        }
                }
                
                Button {
                    Task {
                        
                    }
                } label: {
                    Text("Buscar")
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white).bold()
                        .background(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(searchViewModel.searchText.isEmpty ? .BLUE.opacity(0.3) : .BLUE)
                        )
                }
                .disabled(searchViewModel.searchText.isEmpty ? true : false)
            }
            .padding(.horizontal, 16)
        }
        .safeAreaInset(edge: .top) {
            HStack {
                Spacer()
                Button("Cerrar sesión") {
                    Task {
                        
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    DevSearchView()
}
