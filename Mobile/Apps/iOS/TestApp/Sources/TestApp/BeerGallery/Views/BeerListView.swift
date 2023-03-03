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
		List {
			ForEach(beers) { beer in
				BeerRowView(beer: beer)
			}
		}
		// .listStyle(GroupedListStyle())
		.background(Color.white)
		.cornerRadius(10)
		.font(.headline)

	}
}
