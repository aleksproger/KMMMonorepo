//
//  BearFeatureState+Initial.swift
//  TestApp
//
//  Created by Aleksei Sapitskii on 2.3.2023.
//  Copyright © 2023 Sberbank. All rights reserved.
//

import BeerGallery

extension BeerFeatureState {
	static let initial = BeerFeatureState(loading: true, beers: [], error: KotlinThrowable())
}
