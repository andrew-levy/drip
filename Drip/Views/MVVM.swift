//
//  MVVM.swift
//  Drip
//
//  Created by Andrew Levy on 4/22/21.
//

import SwiftUI



struct MVVM: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct MVVM_Parent: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct MVVM_Child: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

class MVVM_ParentVM: ObservableObject {
    @Published var showSheet = true
}

class MVVM_ChildVM: ObservableObject {
    
}

struct MVVM_Previews: PreviewProvider {
    static var previews: some View {
        MVVM()
    }
}
