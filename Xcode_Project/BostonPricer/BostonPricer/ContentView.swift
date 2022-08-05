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

//    let model = PriceBoston()
    let model: PriceBoston = {
        do {
            let config = MLModelConfiguration()
            return try PriceBoston(configuration: config)
        } catch {
            print(error)
            fatalError("Couldn't create PriceBoston")
        }
    }()

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
                Spacer()
                Spacer()

                VStack {
                    Text("Crime").font(.body)
                    Picker(selection: $pickerCrime, label: Text("")
                        ) {
                        ForEach(0..<crimeData.count, id: \.self) { ix in
                            Text("\(self.crimeData[ix], specifier: "%.2f")").tag(ix)
                        }
                    }

                }

                VStack {
                    Text("No. of Rooms").font(.body)
                    Picker(selection: $pickerRoom, label: Text(""))
                    {
                        ForEach(0..<roomData.count, id: \.self) { ix in
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

        let price = String(format: "%.2f", locale: Locale.current, Double(PriceBoston.price*1000))
//        print(price)

        let Msg = "Your property value is\n $\(price)"

        return Msg
    }

}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()//.environment(\.colorScheme, .dark)
        }
    }
}
#endif
