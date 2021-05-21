//
//  ProgressRingView.swift
//  Drip
//
//  Created by Andrew Levy on 4/19/21.
//

import SwiftUI
import MovingNumbersView

struct RingShape: Shape {
    static func percentToAngle(percent: Double, startAngle: Double) -> Double {
        (percent / 100 * 360) + startAngle
    }
    private var percent: Double
    private var startAngle: Double
    private let drawnClockwise: Bool
    
    var animatableData: Double {
        get {
            return percent
        }
        set {
            percent = newValue
        }
    }
    
    init(percent: Double = 100, startAngle: Double = -90, drawnClockwise: Bool = false) {
        self.percent = percent
        self.startAngle = startAngle
        self.drawnClockwise = drawnClockwise
    }
    
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        let radius = min(width, height) / 2
        let center = CGPoint(x: width / 2, y: height / 2)
        let endAngle = Angle(degrees: RingShape.percentToAngle(percent: self.percent, startAngle: self.startAngle))
        return Path { path in
            path.addArc(center: center, radius: radius, startAngle: Angle(degrees: startAngle), endAngle: endAngle, clockwise: drawnClockwise)
        }
    }
}

struct ProgressRingView: View {
    
    private static let ShadowColor: Color = Color.black.opacity(0.2)
    private static let ShadowRadius: CGFloat = 8
    private static let ShadowOffsetMultiplier: CGFloat = ShadowRadius + 2
    
    private var progress: Float
    private let goal: Float
    private let ringWidth: CGFloat = 25
    private let backgroundColor = Color.blue.opacity(0.2)
    private let foregroundColors = [Color.blue, Color.blue]
    private let startAngle: Double = -90
    private var percent: Double = 0.0
    
    @State private var showProgressNumber = true
    @State private var isPressed = false
    @State private var showShadowCircle = false
    @State private var showProgress = false
    
    
    private var gradientStartAngle: Double {
        self.percent >= 100 ? relativePercentageAngle - 360 : startAngle
    }
    private var absolutePercentageAngle: Double {
        RingShape.percentToAngle(percent: self.percent, startAngle: 0)
    }
    private var relativePercentageAngle: Double {
        absolutePercentageAngle + startAngle
    }
    private var firstGradientColor: Color {
        self.foregroundColors.first ?? .black
    }
    private var lastGradientColor: Color {
        self.foregroundColors.last ?? .black
    }
    private var ringGradient: AngularGradient {
        AngularGradient(
            gradient: Gradient(colors: self.foregroundColors),
            center: .center,
            startAngle: Angle(degrees: self.gradientStartAngle),
            endAngle: Angle(degrees: relativePercentageAngle)
        )
    }
    private var gradient = LinearGradient(
        gradient: Gradient(stops: [
            Gradient.Stop(color: .clear, location: 0),
            Gradient.Stop(color: .black, location: 0.2),
            Gradient.Stop(color: .black, location: 0.8),
            Gradient.Stop(color: .clear, location: 1.0)
        ]),
        startPoint: .top,
        endPoint: .bottom
    )
    
    init(progress: Float, goal: Float) {
        self.progress = progress
        self.goal = goal
        self.percent = Double(progress / goal) * 100
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RingShape()
                    .stroke(style: StrokeStyle(lineWidth: self.ringWidth))
                    .fill(self.backgroundColor)
                RingShape(percent: showProgress ? self.percent : 0, startAngle: self.startAngle)
                    .stroke(style: StrokeStyle(lineWidth: self.ringWidth, lineCap: .round))
                    .fill(self.ringGradient)
                    .animation(Animation.easeInOut(duration: 1))
                    .onChange(of: percent) { newValue in
                        if newValue > 97 {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                                showShadowCircle = true
                            }
                        }
                    }
                VStack {
                    MovingNumbersView(
                        number: showProgressNumber ? Double(progress) : percent,
                        numberOfDecimalPlaces: showProgressNumber ? 2 : 1
                    ) { str in Text(str).font(.system(size: 50)).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/) }
                    .mask(gradient)
                    Text(showProgressNumber ? "gal" : "%").font(.callout)
                }
                if showShadowCircle {
                    Circle()
                        .fill(self.lastGradientColor)
                        .frame(width: self.ringWidth, height: self.ringWidth, alignment: .center)
                        .offset(x: self.getEndCircleLocation(frame: geometry.size).0,
                                y: self.getEndCircleLocation(frame: geometry.size).1)
                        .shadow(color: ProgressRingView.ShadowColor,
                                radius: ProgressRingView.ShadowRadius,
                                x: self.getEndCircleShadowOffset().0,
                                y: self.getEndCircleShadowOffset().1)
                        .scaleEffect(isPressed ? 1.05 : 1)
                }
            }.onTapGesture {
                withAnimation {
                    isPressed = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation {
                        isPressed = false
                    }
                }
                let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                impactHeavy.impactOccurred()
                showProgressNumber.toggle()
            }
            .scaleEffect(isPressed ? 1.05 : 1)
            .onAppear {
                showProgress = false
                withAnimation {
                    showProgress = true
                }
            }
        }
        .padding(self.ringWidth / 2)
    }
    
    private func getEndCircleLocation(frame: CGSize) -> (CGFloat, CGFloat) {
        let angleOfEndInRadians: Double = relativePercentageAngle.toRadians()
        let offsetRadius = min(frame.width, frame.height) / 2
        return (offsetRadius * cos(angleOfEndInRadians).toCGFloat(), offsetRadius * sin(angleOfEndInRadians).toCGFloat())
    }
    
    private func getEndCircleShadowOffset() -> (CGFloat, CGFloat) {
        let angleForOffset = absolutePercentageAngle + (self.startAngle + 90)
        let angleForOffsetInRadians = angleForOffset.toRadians()
        let relativeXOffset = cos(angleForOffsetInRadians)
        let relativeYOffset = sin(angleForOffsetInRadians)
        let xOffset = relativeXOffset.toCGFloat() * ProgressRingView.ShadowOffsetMultiplier
        let yOffset = relativeYOffset.toCGFloat() * ProgressRingView.ShadowOffsetMultiplier
        return (xOffset, yOffset)
    }
    
    private func getShowShadow(frame: CGSize) -> Bool {
        let circleRadius = min(frame.width, frame.height) / 2
        let remainingAngleInRadians = (360 - absolutePercentageAngle).toRadians().toCGFloat()
        if self.percent >= 100 {
            return true
        } else if circleRadius * remainingAngleInRadians <= self.ringWidth {
            return true
        }
        return false
    }
}

struct ProgressRingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProgressRingView(
                progress: 1.5,
                goal: 2
            )
            .frame(width: 300, height: 300)
            .previewLayout(.sizeThatFits)
        }
    }
}
