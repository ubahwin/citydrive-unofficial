import SwiftUI

struct AboutCarView: View {
    var car: CarOrder?

    var body: some View {
        Form {
            HStack {
                Text(car?.model ?? "")
                    .font(.title2)
                    .bold()
                Spacer()
                CarNumberView(number: car?.number)
            }
            .padding()
            HStack {
                Spacer()
                AsyncImage(url: URL(string: car?.img ?? "")) { image in // img
                    image
                } placeholder: {
                    Image(systemName: "car")
                }
                Spacer()
            }
            Section("Значения одометра") {
                SimpleCellView(name: "В начале", value: car?.odometer.atStart)
                SimpleCellView(name: "В конце", value: car?.odometer.atFinish)
            }
            SimpleCellView(name: "ID", value: car?.id).textSelection(.enabled)
        }
    }
}

#Preview {
    AboutCarView(
        car: CarOrder(
            id: "1",
            model: "Kia Ria",
            img: "https://admin.citydrive.ru/static/img/cars/citydrive/chery_tiggo_4/moscow/white_face.png",
            number: CarNumber(number: "а123аа231"),
            odometer: Odometer(atStart: 21, atFinish: 423)
        )
    )
}
