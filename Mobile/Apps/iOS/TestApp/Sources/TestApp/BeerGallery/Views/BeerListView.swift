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
	var beers: [DTOBeer]

	var body: some View {
		ScrollView {
			LazyVGrid(columns: [GridItem(.flexible())], spacing: 20) {
				ForEach(beers) { beer in
					Widget(BeerRowView(beer: beer))
				}
			}
		}
//		List {
//			ForEach(beers) { beer in
//				BeerRowView(beer: beer)
//			}
//		}
//		// .listStyle(GroupedListStyle())
//		.background(Color.white)
//		.cornerRadius(10)
//		.font(.headline)

	}
}

struct Widget<V: View>: View {
	private let subject: V
	
	init(_ subject: V) {
		self.subject = subject
	}
	
	var body: some View {
		ZStack {
			subject
		}
		.cornerRadius(10)
		.background(Color.mint)
	}
}
