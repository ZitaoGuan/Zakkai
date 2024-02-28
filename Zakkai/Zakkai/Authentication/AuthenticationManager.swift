//
//  Authenication.swift
//  Zakkai
//
//  Created by Noah Giboney on 2/16/24.
//

import FirebaseAuth
import Observation
import SwiftUI

struct AuthDataModel {
    let uid: String
    let email: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
    }
}

@MainActor
final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    private init() { }
    
    func signIn(email: String, password: String) async throws -> AuthDataModel{
        let authData = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataModel(user: authData.user)
    }
    
    func createUser(email: String, password: String) async throws -> AuthDataModel {
        let authData = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataModel(user: authData.user)
    }
    
    func getAuthenticatedUser() throws -> AuthDataModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse) // update later with better response
        }
        return AuthDataModel(user: user)
    }
    
    func logOut() throws {
        try Auth.auth().signOut()
    }
    
    func resetPassword(email: String) async throws{
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
}
