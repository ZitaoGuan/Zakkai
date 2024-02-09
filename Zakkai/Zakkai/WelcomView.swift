//
//  WelcomView.swift
//  Zakkai
//
//  Created by Zitao Guan on 2/7/24.
//

import SwiftUI

struct WelcomView: View {

    @State var showSignIn: Bool = false
    @State var showSignUp: Bool = false

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
                Text("Changing the World, One Tap at a Time")
                    .multilineTextAlignment(.center)
                    .font(.customfont(.regular, fontSize: 14))
                    .padding(.horizontal, 20)
                    .foregroundColor(.black)
                    .padding(.bottom, 30)
                
                NavigationLink(destination: SocialSignupView(), isActive: $showSignUp) {
                            PrimaryButton(title: "Get Started", onPressed: {
                                showSignUp.toggle()
                            })
                            .padding(.bottom, 15)
                        }

                        NavigationLink(destination: SignInView(), isActive: $showSignIn) {
                            SecondaryButton(title: "I have an account", onPressed: {
                                showSignIn.toggle()
                            })
                        }
                        .padding(.bottom, .bottomInsets)
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

struct WelcomView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomView()
    }
}
