//
//  BarView.swift
//  Drip
//
//  Created by Andrew Levy on 4/19/21.
//

import SwiftUI

struct BarView: View {
    var value: Double
    @State var showBar = false
    var body: some View {
        ZStack(alignment: .bottom) {
            Capsule()
                .frame(width: 20, height: 100)
                .foregroundColor(Color(r: 21, g: 100, b: 224))
            Capsule()
                .frame(width: 20, height: showBar ? CGFloat(value) : 0)
                .foregroundColor(.white)
                .animation(.default)
        }.onAppear {
            showBar = false
            withAnimation {
                showBar = true
            }
        }
    }
}

struct BarView_Previews: PreviewProvider {
    static var previews: some View {
        BarView(value: 40)
    }
}
