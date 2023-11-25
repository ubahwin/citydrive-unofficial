import Foundation
import SwiftUI

struct CarNumberView: View {
    var number: CarNumber?

    var body: some View {
        VStack {
            ZStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(lineWidth: 1)
                        .frame(width: 104, height: 31)
                    Rectangle()
                        .frame(width: 1, height: 31)
                        .offset(CGSize(width: 20, height: 0))
                }
                .foregroundStyle(.gray)

                HStack(spacing: 1) {
                    Text(number?.firstChar ?? "")
                    Text(number?.numbers ?? "")
                    Text(number?.lastChars ?? "")
                }
                .font(.system(size: 15))
                .offset(CGSize(width: -15, height: 0))

                Text(number?.region ?? "")
                    .offset(CGSize(width: 36, height: -5))
                    .font(.system(size: 14))

                Text("RUS")
                    .offset(CGSize(width: 30, height: 8.5))
                    .font(.system(size: 6))
                // flag
                Rectangle()
                    .stroke(lineWidth: 0.2)
                    .frame(width: 10, height: 6)
                    .offset(CGSize(width: 43, height: 8))
                Rectangle()
                    .fill(.white)
                    .frame(width: 10, height: 2)
                    .offset(CGSize(width: 43, height: 6))
                Rectangle()
                    .fill(.blue)
                    .frame(width: 10, height: 2)
                    .offset(CGSize(width: 43, height: 8))
                Rectangle()
                    .fill(.red)
                    .frame(width: 10, height: 2)
                    .offset(CGSize(width: 43, height: 10))
            }
        }
    }
}

#Preview {
    CarNumberView(number: CarNumber(number: "а919аа778"))
}
