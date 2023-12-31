import SwiftUI

struct BottomCarSheetView<Content: View>: View {
    @Binding var isFull: Bool
    @Binding var isOpen: Bool

    let outOfZone: Bool
    let content: Content

    let redOffset: CGFloat = 50
    @GestureState private var translation: CGFloat = 0

    var maxHeight: CGFloat {
        outOfZone ? 500 : 450
    }

    var minHeight: CGFloat {
        outOfZone ? 350 : 300
    }

    private var offset: CGFloat {
        isFull ? 0 : maxHeight - minHeight
    }

    init(
        isFull: Binding<Bool>,
        isOpen: Binding<Bool>,
        outOfZone: Bool,
        @ViewBuilder content: () -> Content
    ) {
        self._isFull = isFull
        self._isOpen = isOpen
        self.outOfZone = outOfZone
        self.content = content()
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ZStack {
                    if outOfZone {
                        Rectangle()
                            .fill(.red)
                            .clipShape(.rect(cornerRadius: 15))
                        VStack {
                            Text("Вне зоны завершения аренды")
                                .font(.footnote)
                                .foregroundStyle(.white)
                                .opacity(0.8)
                                .padding()
                            Spacer()
                        }
                    }
                    content
                        .offset(y: outOfZone ? 50 : 0)
                }
                VStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.gray)
                        .frame(width: 35, height: 4)
                        .offset(y: outOfZone ? redOffset : 0)
                        .padding(8)
                        .onTapGesture {
                            self.isOpen.toggle()
                        }
                    Spacer()
                }
            }
            .ignoresSafeArea()
            .frame(maxHeight: maxHeight)
            .frame(height: geometry.size.height, alignment: .bottom)
            .offset(y: max(offset + translation, 0))
            .gesture(
                DragGesture()
                    .updating($translation) { value, state, _ in
                        withAnimation {
                            state = value.translation.height
                        }
                    }
                    .onEnded { value in
                        let snapDistance = maxHeight * 0.25
                        guard abs(value.translation.height) > snapDistance else { return }
                        isOpen = isFull || value.translation.height < 0
                        isFull = value.translation.height < 0
                    }
            )
        }
    }
}

#Preview {
    BottomCarSheetView(
        isFull: Binding.constant(true),
        isOpen: Binding.constant(true),
        outOfZone: false,
        content: { Rectangle().fill(.blue) }
    )
}
