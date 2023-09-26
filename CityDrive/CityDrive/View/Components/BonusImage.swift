import SwiftUI

struct BonusImage: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://api.citydrive.ru/static/img/loyalty/drivebonus_x4.png")) { image in
            image
                .resizable()
                .frame(width: 20, height: 20)
        } placeholder: {
            ProgressView()
        }
    }
}
