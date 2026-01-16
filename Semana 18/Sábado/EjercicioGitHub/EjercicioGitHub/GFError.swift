//
//  Error.swift
//  EjercicioGitHub
//
//  Created by Franco Ruiz on 16/01/26.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername    = "Usuario no Encontrado o Inválido. Intenta de nuevo."
    case unableToComplete   = "Por favor revisa tu conexión a internet."
    case invalidResponse    = "Respuesta inválida o Usuario no encontrado. Por favor intenta de nuevo."
    case invalidData        = "Los datos recibidos del servidor son inválidos. Por favor intenta de nuevo."
    case unableToFavorite   = "No se pudo guardar en favoritos. Por favor intenta de nuevo."
    case alreadyInFavorites = "Este usuario ya está en tus favoritos."
}
