import BeerGallery
import SwiftUI
import iOSAppUtilities

struct BeerRowView: View {
	var beer: DTOBeer

	var body: some View {
		VStack {
			URLImage(beer.url, InMemoryImageCache.shared, ProgressView()) {  image in
				image
					.resizable()
					.aspectRatio(contentMode: .fit)
			}
			.frame(width: 100, height: 100)
			
			Text(beer.name)
				.font(.title2)
				.bold()
		}
		.padding(.vertical, 8)
	}
}