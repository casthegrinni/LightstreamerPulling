//
//  ContentView.swift
//  LightstreamerStocksPulling
//
//  Created by Brunno Castigrini on 30/06/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: LightstreamerViewModel
    var body: some View {
       
        VStack {
            Text("LightStreamer Stocks Pulling")
                .frame(width: .infinity, alignment: .trailing)
                .font(.system(size: 22,
                              weight: .semibold,
                              design: .default))
            List {
                HStack {
                    HStack {
                        Text("Stock:")
                            .font(.system(size: 20,
                                          weight: .semibold,
                                          design: .default))
                        
                        Text("APPLE")
                            .font(.system(size: 18,
                                          weight: .medium,
                                          design: .rounded))
                    }
                    
                    Spacer()
                    HStack {
                        Text("Price:")
                            .font(.system(size: 20,
                                          weight: .semibold,
                                          design: .default))
                        Text("\(0.0, specifier: "%.2f")")
                            .font(.system(size: 18,
                                          weight: .medium,
                                          design: .rounded))
                    }
                }.padding([.top, .bottom], 10)
                
            }
        }.frame(width: .infinity, alignment: .trailing)
            .onAppear { self.viewModel.connect() }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: LightstreamerViewModel())
    }
}
