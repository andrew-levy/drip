//
//  ImagePickerSheetView.swift
//  Drip
//
//  Created by Andrew Levy on 4/19/21.
//

import SwiftUI

struct ImagePickerSheetView: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    @Binding var selectedImage: UIImage
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerSheetView>) -> UIViewController {
        let controller = UIImagePickerController()
        controller.delegate =  context.coordinator
        return controller
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePickerSheetView
        init (parent: ImagePickerSheetView) {
            self.parent = parent
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                parent.selectedImage = selectedImage
            }
            parent.isPresented = false
        }
    }
    
    func updateUIViewController(_ uiViewController: ImagePickerSheetView.UIViewControllerType, context: UIViewControllerRepresentableContext<ImagePickerSheetView>) {
    }
}

struct ImagePickerSheetView_Previews: PreviewProvider {
    @State static var isPresented = true
    @State static var selectedImage = UIImage()
    static var previews: some View {
        ImagePickerSheetView(isPresented: $isPresented, selectedImage: $selectedImage)
    }
}
