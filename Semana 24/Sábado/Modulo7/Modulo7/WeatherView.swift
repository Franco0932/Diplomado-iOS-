//
//  WeatherView.swift
//  Modulo7
//
//  Created by Franco Ruiz on 21/02/26.
//

import SwiftUI
import MapKit

struct WeatherView: View {
    let locationItem: Location
    @EnvironmentObject var favorites: Favorites
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        ZStack {
            if let weather = viewModel.weather {
                if weather.current.is_day == 1 {
                    Color("Day").ignoresSafeArea()
                } else {
                    Color("Nigth").ignoresSafeArea()
                }
            } else {
                Color(uiColor: .systemBackground).ignoresSafeArea()
            }
            
            if viewModel.isLoading {
                ProgressView("Cargando")
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.5)
            } else if let weather = viewModel.weather {
                ScrollView {
                    VStack(spacing: 20) {
                        Text(weather.location.country)
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.top, 10)
                        
                        Picker("Temperatura", selection: $viewModel.tempUnit) {
                            Text("C").tag(TemperatureUnit.celsius)
                            Text("F").tag(TemperatureUnit.fahrenheit)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 150)
                        
                        HStack {
                            AsyncImage(url: URL(string: "https:\(weather.current.condition.icon)")) { image in
                                image.resizable().scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 80, height: 80)
                            
                            Spacer()
                            
                            Text("\(Int(viewModel.tempUnit == .celsius ? weather.current.temp_c : weather.current.temp_f))°")
                                .font(.system(size: 80, weight: .regular))
                            
                            Spacer()
                            
                            Text("UV: \(weather.current.uv, specifier: "%.1f")")
                                .font(.title3)
                        }
                        .padding(.horizontal, 30)
                        
                        Text(viewModel.formatDate(weather.location.localtime))
                            .font(.headline)
                            .fontWeight(.regular)
                        
                        Map(position: $viewModel.position)
                            .frame(height: 250)
                            .cornerRadius(0)
                        
                        HStack {
                            Spacer()
                            Text("Last update: \(viewModel.formatDate(weather.current.last_updated))")
                                .font(.footnote)
                        }
                        .padding(.horizontal)
                    }
                    .foregroundColor(.white)

                }
            }
        }
        .navigationTitle(viewModel.weather?.location.name ?? locationItem.nombre)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    favorites.toggleFavorites(id: locationItem.id)
                }) {
                    Image(systemName: favorites.isFavorite(id: locationItem.id) ? "star.fill" : "star")
                        .foregroundColor(favorites.isFavorite(id: locationItem.id) ? .blue : .blue)
                }
            }
        }
        .task {
            await viewModel.fetchWeather(city: locationItem.nombre)
        }
        .alert(isPresented: $viewModel.showErrorAlert) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorMessage ?? "Hubo un problema al cargar el clima."),
                dismissButton: .default(Text("OK")) {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}
