import SwiftUI

struct Avatar: View {
    var image: Image?

    init(image: Image? = nil) {
        self.image = image
    }

    var body: some View {
        if image != nil {
            image!
                .resizable()
                .clipShape(Circle())
                .frame(width: 60, height: 60)
        } else {
            ProgressView()
                .clipShape(Circle())
                .frame(width: 60, height: 60)
        }
    }
}
