//
//  BudgeRow.swift
//  Zakkai
//
//  Created by Zitao Guan on 2/7/24.
//

import SwiftUI

struct BudgetRow: View {
    @State var bObj: BudgetModel = BudgetModel(dict: [ "name": "Auto & Transport",
                                                       "icon": "auto_&_transport",
                                                       "spend_amount": "25.99",
                                                       "total_amount": "400",
                                                       "left_amount": "250.01",
                                                       "color": Color.secondaryG ] )
    var body: some View {
        
        VStack{
            HStack{
                
                Image(bObj.icon)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.gray)
                
                VStack{
                    Text(bObj.name)
                        .font(.customfont(.semibold, fontSize: 14))
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    Text("$\(bObj.left_amount) donated")
                        .font(.customfont(.semibold, fontSize: 12))
                        .foregroundColor(.gray30)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                
                VStack(alignment: .trailing){
                    Text("$\(bObj.total_amount)")
                        .font(.customfont(.semibold, fontSize: 14))
                        .foregroundColor(.white)
                        .frame(alignment: .trailing)
                    
                    Text("$\(bObj.left_amount) out of")
                        .font(.customfont(.semibold, fontSize: 12))
                        .foregroundColor(.gray30)
                        .frame(alignment: .trailing)
                }
            }
            ProgressView(value: bObj.perSpend, total: 1)
                .tint(bObj.color)
        }
        
        .padding(15)
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color.gray.opacity( 0.2  ))
        .overlay {
            RoundedRectangle(cornerRadius:  12)
                .stroke(  Color.gray, lineWidth: 1)
        }
        .cornerRadius(12)
    }
}

struct BudgetRow_Previews: PreviewProvider {
    static var previews: some View {
        BudgetRow()
    }
}
