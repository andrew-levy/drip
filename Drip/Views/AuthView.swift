//
//  AuthView.swift
//  Drip
//
//  Created by Andrew Levy on 4/16/21.
//

import SwiftUI

struct AuthView: View {
    @State var toggleSignIn: Bool
    var body: some View {
        toggleSignIn ? SignInView() : SignUpView()
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
