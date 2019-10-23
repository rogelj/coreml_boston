//
//  ContentView.swift
//  BostonPricer
//
//  Created by Jesus Rogel on 09/10/2019.
//  Copyright © 2019 Jesus Rogel. All rights reserved.
//

import SwiftUI
import CoreML

struct ContentView: View {

    let model = PriceBoston()

    let crimeData = Array(stride(from: 0.05, through: 3.7, by: 0.1))
    let roomData = Array(4...9)

    @State var popUpVisible: Bool = false
    @State var pickerCrime = 0
    @State var pickerRoom = 0

    var body: some View {
        NavigationView {
            VStack {
                Text("Boston Pricer")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)

                VStack {
                    Picker(selection: $pickerCrime, label: Text("Crime")
                        .font(.body)

                        ) {
                        ForEach(0..<crimeData.count) { ix in
                            Text("\(self.crimeData[ix], specifier: "%.2f")").tag(ix)
                        }
                    }

                    Picker(selection: $pickerRoom, label: Text("No. Rooms").font(.body)) {
                        ForEach(0..<roomData.count) { ix in
                            Text("\(self.roomData[ix])").tag(ix)
                        }
                    }
                }

                Button(action: {
                    self.popUpVisible = true
                }) {
                    Text("Get Prediction")
                }
                .alert(isPresented: self.$popUpVisible) {
                    Alert(title: Text("Property Valuation"),
                          message: Text(predictionMsg()),
                        dismissButton: .default(Text("OK"))
                    )
                }.padding()

                Spacer()
            }
        }
    .navigationViewStyle(StackNavigationViewStyle())
    }

    // Methods
    // ========
    func predictionMsg() -> String {
        let crime = crimeData[pickerCrime]
        let rooms = Double(roomData[pickerRoom])
//        print(crime, rooms)

        guard let PriceBoston = try? model.prediction(crime: crime, rooms: rooms) else {
            fatalError("Unexpected runtime error.")
        }

        let price = String(format: "%.2f", PriceBoston.price*1000)
//        print(price)

        let Msg = "Your property value is\n $\(price)"

        return Msg
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
