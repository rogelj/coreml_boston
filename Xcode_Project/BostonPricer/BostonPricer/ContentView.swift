//
//  ContentView.swift
//  BostonPricer
//
//  Created by Jesus Rogel on 09/10/2019.
//  Copyright © 2019 Jesus Rogel. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Boston Pricer")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding()

                HStack {
                    Text("Crime Rate").padding(.trailing, 40)
                    Text("No. Rooms").padding(.leading, 40)
                }

                Spacer()

                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Get Prediction")
                }

                Spacer()
            }
        }
    .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
