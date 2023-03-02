import BeerGallery
import SwiftUI

struct BeerRowView: View {
	var beer: DTOBeer

	var body: some View {
		HStack {
			VStack(alignment: .leading) {
				Text(beer.name)
					.font(.title)
				Text(beer.description_)
					.font(.subheadline)
					.foregroundColor(.gray)
			}
		}
		.padding(.vertical, 8)
	}
}
