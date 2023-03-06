import BeerGallery
import SwiftUI
import iOSUI

struct BeerRowView: View {
	var beer: DTOBeer

	var body: some View {
		VStack {
			AsyncImage(url: beer.url) { image in
				image.resizable()
			} placeholder: {
				ProgressView()
			}
			.frame(width: 100, height: 100)
			
			Text(beer.name)
				.font(.title2)
				.bold()
		}
		.padding(.vertical, 8)
	}
}
