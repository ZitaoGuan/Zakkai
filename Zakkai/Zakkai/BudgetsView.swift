//
//  BudgetsView.swift
//  Zakkai
//
//  Created by Zitao Guan on 2/7/24.
//

import SwiftUI

struct HistoryView: View {
    @State var listArr: [BudgetModel] = [
        BudgetModel(dict: [ "name": "Feeding America",
                            "icon": "Feeding_America",
                            "spend_amount": "25.99",
                            "total_amount": "400",
                            "left_amount": "250.00",
                            "color": Color.secondaryG ] ),
        
        BudgetModel(dict: [ "name": "Salvation Army",
                            "icon": "Salvation_army",
                            "spend_amount": "50.99",
                            "total_amount": "600",
                            "left_amount": "300.01",
                            "color": Color.secondaryC ] ),
        
        BudgetModel(dict: [ "name": "St. Jude",
                            "icon": "St. Jude",
                            "spend_amount": "5.99",
                            "total_amount": "600",
                            "left_amount": "250.01",
                            "color": Color.primary10 ] )
    ]
    
    @State var arcArr : [ArcModel] = []
    
    var body: some View {
        ZStack {
            Image("welcome_screen") // Set the background image
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
            
            ScrollView {
                
                ZStack(alignment: .bottom){
                    
                    ZStack {
                        
                        ArcShape180(width: 10)
                            .foregroundColor(.gray.opacity(0.2))
                        
                        ForEach(arcArr, id: \.id) { aObj in
                            
                            ArcShape180(start: aObj.statVal, end: aObj.value - 9, width: 14)
                                .foregroundColor(aObj.color)
                                .shadow( color: aObj.color.opacity(0.5), radius: 7)
                            
                        }
                    }
                    .frame(width: .widthPer(per: 0.5), height: .widthPer(per: 0.3))
                    
                    
                    VStack{
                        Text("$82,90")
                            .font(.customfont(.bold, fontSize: 24))
                            .foregroundColor(.white)
                        
                        Text("of $2,0000 donated")
                            .font(.customfont(.medium, fontSize: 12))
                            .foregroundColor(.gray30)
                    }
                    
                    
                    
                }
                .padding(.top, 64 )
                .padding(.bottom, 30 )
                
                
                Button {
                    
                } label: {
                    Text("You've feed more than 20,000 people!")
                        .font(.customfont(.semibold, fontSize: 14))
                }
                .foregroundColor( .white )
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 64, maxHeight: 64)
                
                
                .overlay {
                    RoundedRectangle(cornerRadius:  16)
                        .stroke(  Color.blue, lineWidth: 1)
                }
                .cornerRadius(16)
                .padding(.horizontal, 20)
                
                .padding(.vertical, 10)
                
                LazyVStack(spacing: 15) {
                    ForEach( listArr , id: \.id) { bObj in
                        
                        BudgetRow(bObj: bObj)
                        
                    }
                }
                .padding(.horizontal, 20)
                
            }
            .onAppear{
                getArcProgressData()
            }
            .ignoresSafeArea()
        }
    }
    
    func getArcProgressData(){
        
        var data = [
            ArcModel(value: 20, color: .secondaryG),
            ArcModel(value: 45, color: .secondaryC),
            ArcModel(value: 70, color: .primary10)
        ]
        
        var val = 0.0
        
        for i in (0 ..<  data.count) {
            data[i].statVal = val
            val = data[i].statVal + data[i].value + 2
        }
        
        arcArr = data
        
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
