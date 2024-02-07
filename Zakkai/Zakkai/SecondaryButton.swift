//
//  SecondaryButton.swift
//  Zakkai
//
//  Created by Zitao Guan on 2/7/24.
//

import SwiftUI

struct SecondaryButton: View {
    @State var title: String = "Title"
    var onPressed: (()->())?
    
    var body: some View {
        Button {
            onPressed?()
        } label: {
            ZStack{
                Image("secodry_btn")
                    .resizable()
                    .scaledToFill()
                    .padding(.horizontal, 20)
                    .frame(width: .infinity, height: 48)
                
                Text(title)
                    .font(.customfont(.semibold, fontSize: 14))
                    .padding(.horizontal, 20)
            }
        }
        .foregroundColor(.black)
       
    }
}

struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryButton()
    }
}
