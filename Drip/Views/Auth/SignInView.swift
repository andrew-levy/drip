//
//  SignInView.swift
//  Drip
//
//  Created by Andrew Levy on 4/16/21.
//

import SwiftUI

struct SignInView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Sign In").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Spacer()
                NavigationLink(
                    destination: SignUpView(),
                    label: {
                        Text("I don't have a drip account yet")
                    })
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
