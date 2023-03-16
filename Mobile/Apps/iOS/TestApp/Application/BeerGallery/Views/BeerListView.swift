//
//  BeerListView.swift
//  TestApp
//
//  Created by Aleksei Sapitskii on 2.3.2023.
//  Copyright © 2023 Sberbank. All rights reserved.
//

import Foundation
import BeerGallery
import SwiftUI

struct BeerListView: View {
	var beers: [DTOBeerViewModel]

	@StateObject var backgroundCalculator = BackgroundCalculator()

	var body: some View {
		ZStack {
			backgroundCalculator.color
				.ignoresSafeArea()

			GeometryReader { g in
				ScrollView(.horizontal, showsIndicators: false) {
					ZStack {
						GeometryReader { proxy in
							let offset = proxy.frame(in: .named("scroll")).minX
							Color.clear.preference(key: ScrollViewOffsetPreferenceKey.self, value: offset)
						}
						LazyHStack(spacing: 0) {
							ForEach(beers) { beer in
								Widget(BeerRowView(beer: beer))
									.frame(width: g.size.width, height: g.size.height)
							}
						}
					}
				}
				.coordinateSpace(name: "scroll")
				.onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
					backgroundCalculator.calucateBackground(position: -value)
				}
				.onAppear {
					backgroundCalculator.width = g.size.width
					backgroundCalculator.colors = beers.map { Color(hex: $0.average_color) }
				}
			}
			.ignoresSafeArea()
		}
	}
}

struct Widget<V: View>: View {
	private let subject: V
	
	init(_ subject: V) {
		self.subject = subject
	}
	
	var body: some View {
			subject
				.background(.gray.opacity(0.15))
				.cornerRadius(24)
				.padding(64)
	}
}


extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}