//
//  ResetPasswordView.swift
//  Zakkai
//
//  Created by Noah Giboney on 2/18/24.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var email = ""
    @State private var showSentAlert = false
    @State private var showingErrorAlert = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationStack{
            ZStack{
                Image("welcome_screen")
                    .resizable()
                    .scaledToFill()
                    .rotationEffect(.degrees(180))
                    .frame(width: .screenWidth, height: .screenHeight)
                            
                VStack{
                    Spacer()
                    RoundTextField(title: "Email Address", text: $email, keyboardType: .emailAddress)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 15)
                    
                    PrimaryButton(title: "Send Reset") {
                        Task{
                            do {
                                guard email.isValidEmail() else{
                                    errorMessage = "Invalid Email Address."
                                    showingErrorAlert.toggle()
                                    return
                                }
                                try await resetPassword()
                                showSentAlert.toggle()
                            } catch{
                                errorMessage = error.localizedDescription
                                showingErrorAlert.toggle()
                            }
                        }
                    }
                    Spacer()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    Button("Close"){
                        dismiss()
                    }
                }
            }
        }
        .alert("Reset Password", isPresented: $showSentAlert) {
        } message: {
            Text("An email has been sent to \(email) to reset your password.")
        }
        .alert("Error", isPresented: $showingErrorAlert) {
        } message: {
            Text(errorMessage)
        }
    }
    
    func resetPassword() async throws {
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
    
}

#Preview {
    ResetPasswordView()
}

extension String {
    func isValidEmail() -> Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailPattern)
        return emailPred.evaluate(with: self)
    }
}
