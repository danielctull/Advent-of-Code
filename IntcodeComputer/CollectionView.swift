
import SwiftUI

struct Offset {
    let horizontal: CGFloat
    let vertical: CGFloat
}

struct FlowLayout {
    let spacing: Offset
    let containerSize: CGSize

    init(containerSize: CGSize, spacing: Offset = Offset(horizontal: 10, vertical: 10)) {
        self.spacing = spacing
        self.containerSize = containerSize
    }

    var currentX = 0 as CGFloat
    var currentY = 0 as CGFloat
    var lineHeight = 0 as CGFloat

    mutating func add(element size: CGSize) -> CGRect {
        if currentX + size.width > containerSize.width {
            currentX = 0
            currentY += lineHeight + spacing.vertical
            lineHeight = 0
        }
        defer {
            lineHeight = max(lineHeight, size.height)
            currentX += size.width + spacing.horizontal
        }
        return CGRect(origin: CGPoint(x: currentX, y: currentY), size: size)
    }

    var size: CGSize {
        return CGSize(width: containerSize.width, height: currentY + lineHeight)
    }
}

func flowLayout<Elements>(for elements: Elements, containerSize: CGSize, sizes: [Elements.Element.ID: CGSize]) -> [Elements.Element.ID: CGSize] where Elements: RandomAccessCollection, Elements.Element: Identifiable {
    var state = FlowLayout(containerSize: containerSize)
    var result: [Elements.Element.ID: CGSize] = [:]
    for element in elements {
        let rect = state.add(element: sizes[element.id] ?? .zero)
        result[element.id] = CGSize(width: rect.origin.x, height: rect.origin.y)
    }
    return result
}

protocol Layout {
//    init(containerSize: CGSize, spacing: Offset = Offset(horizontal: 10, vertical: 10))
}

struct CollectionView<Data, Content>: View
where
Data: RandomAccessCollection,
Content: View,
Data.Element: Identifiable {

    typealias ID = Data.Element.ID

    var data: Data
    var layout: (Data, CGSize, [ID: CGSize]) -> [ID: CGSize]
    var content: (Data.Element) -> Content

    @State private var sizes: [ID: CGSize] = [:]

    private func bodyHelper(containerSize: CGSize, offsets: [ID: CGSize]) -> some View {
        ZStack(alignment: .topLeading) {
            ForEach(data) {
                self.content($0)
                    .propagateSize(id: $0.id)
                    .offset(offsets[$0.id] ?? CGSize.zero)
                    .animation(nil)
            }
            Color.clear
                .frame(idealWidth: containerSize.width, minHeight: 50, idealHeight: containerSize.height)
                .fixedSize()
        }.onPreferenceChange(CollectionViewSizeKey.self) {
            self.sizes = $0
        }
    }

    var body: some View {
        GeometryReader { proxy in
            self.bodyHelper(containerSize: proxy.size, offsets: self.layout(self.data, proxy.size, self.sizes))
        }
    }
}

// Size propagation

struct CollectionViewSizeKey<ID: Hashable>: PreferenceKey {
    static var defaultValue: [ID: CGSize] { [:] }
    static func reduce(value: inout [ID: CGSize], nextValue: () -> [ID: CGSize]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

extension View {
    func propagateSize<ID: Hashable>(id: ID) -> some View {
        self.background(GeometryReader { proxy in
            Color.clear.preference(key: CollectionViewSizeKey<ID>.self, value: [id: proxy.size])
        })
    }
}
