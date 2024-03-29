//
//  BeerGalleryView.swift
//  TestApp
//
//  Created by Aleksei Sapitskii on 2.3.2023.
//  Copyright © 2023 Sberbank. All rights reserved.
//

import BeerGallery
import iOSArchitectureAPI
import SwiftUI

struct BeerGalleryView: View {
	@ObservedObject
	var viewStore: ObservableObjectStore<BeerViewStoreAdapter>

	var body: some View {
		if viewStore.state.loading {
			IndicatorView(color: .black, lineWidth: 15)
				.frame(width: 96, height: 96)
		} else {
			
			BeerListView(beers: viewStore.state.beers)
		}
	}
}
