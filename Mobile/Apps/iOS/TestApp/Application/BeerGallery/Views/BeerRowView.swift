import BeerGallery
import SwiftUI
import iOSAppUtilities

struct BeerRowView: View {
	var beer: DTOBeerViewModel

	var body: some View {
		VStack {
			URLImage(beer.url, InMemoryImageCache.shared, ProgressView()) {  image in
				image
					.resizable()
					.aspectRatio(contentMode: .fit)
			}
			
			Text(beer.name)
				.font(.title2)
				.bold()
				.foregroundColor(.white.opacity(0.65))
				.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
		}
		.padding(.vertical, 16)
		.padding(.horizontal, 16)
	}
}