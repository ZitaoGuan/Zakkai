//
//  SignUpView.swift
//  Zakkai
//
//  Created by Zitao Guan on 2/7/24.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    
    @State var txtEmail: String = ""
    @State var txtPassword: String = ""
    @State var showSignIn: Bool = false
    
    var body: some View {
        ZStack{
            Image("welcome_screen")
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth, height: .screenHeight)
                        
            VStack{
                
                Image("app_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: .widthPer(per: 0.5) )
                    .padding(.top, .topInsets + 8)
                
                
                Spacer()
                
                RoundTextField(title: "E-mail Address", text: $txtEmail, keyboardType: .emailAddress)
                
                .padding(.horizontal, 20)
                .padding(.bottom, 15)
                
                
                RoundTextField(title: "Passowrd", text: $txtPassword, isPassword: true)
                
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                HStack {
                    
                    Rectangle()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 5, maxHeight: 5)
                        .padding(.horizontal, 1)
                    
                    Rectangle()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 5, maxHeight: 5)
                        .padding(.horizontal, 1)
                    
                    Rectangle()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 5, maxHeight: 5)
                        .padding(.horizontal, 1)
                    
                    Rectangle()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 5, maxHeight: 5)
                        .padding(.horizontal, 1)
                    
                }
                .padding(.horizontal, 20)
                .foregroundColor(.gray70)
                .padding(.bottom, 20)
                
                Text("Use 8 or more characters with a mix of letters,\nnumbers & symbols.")
                    .multilineTextAlignment(.leading)
                    .font(.customfont(.regular, fontSize: 14))
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .foregroundColor(.gray50)
                    .padding(.bottom, 20)
                
                PrimaryButton(title: "Get Started, it's free!", onPressed: {
                    signUp()
                })
                
                Spacer()
                
                Text("Do you have already an account?")
                    .multilineTextAlignment(.center)
                    .font(.customfont(.regular, fontSize: 14))
                    .padding(.horizontal, 20)
                    .foregroundColor(.gray50)
                    .padding(.bottom, 20)
                
                SecondaryButton(title: "Sign In", onPressed: {
                    showSignIn.toggle()
                })
//                .background( NavigationLink(destination: SignInView(), isActive: $showSignIn, label: {
//                    EmptyView()
//                }) )
                .navigationTitle("navigate button")
                .navigationDestination(isPresented: $showSignIn){
                    SignInView()
                }
                .padding(.bottom, .bottomInsets + 8)
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
    
    private func signUp() {
        Auth.auth().createUser(withEmail: txtEmail, password: txtPassword){ result, error in
            if let error = error {
                print("error creating user")
                
            } else{
                print(" user created successfully")
            }
        }
    }
}



struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
