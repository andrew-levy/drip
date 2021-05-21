//
//  WeekView.swift
//  Drip
//
//  Created by Andrew Levy on 4/18/21.
//

import SwiftUI

struct WeekView: View {
    @State var heights: [Double] = [10,20,30,40,50,60,70]
    var body: some View {
        ZStack {
            Color(UIColor.systemBlue).ignoresSafeArea(edges: .all)
            VStack(alignment: .center) {
                Text("Week")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                Spacer()
                HStack(spacing: 15) {
                    VStack {
                        BarView(value: heights[0])
                        Text("su").foregroundColor(.white).bold()
                    }
                    VStack {
                        BarView(value: heights[1])
                        Text("m").foregroundColor(.white).bold()
                    }
                    VStack {
                        BarView(value: heights[2])
                        Text("t").foregroundColor(.white).bold()
                    }
                    VStack {
                        BarView(value: heights[3])
                        Text("w").foregroundColor(.white).bold()
                    }
                    VStack {
                        BarView(value: heights[4])
                        Text("th").foregroundColor(.white).bold()
                    }
                    VStack {
                        BarView(value: heights[4])
                        Text("f").foregroundColor(.white).bold()
                    }
                    VStack {
                        BarView(value: heights[5])
                        Text("sa").foregroundColor(.white).bold()
                    }
                }
                Spacer()
            }
        }
        
    }
}

struct WeekView_Previews: PreviewProvider {
    static var previews: some View {
        WeekView()
    }
}
