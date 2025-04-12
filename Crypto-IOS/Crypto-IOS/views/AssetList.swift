import SwiftUI

struct AssetList: View{
    
    @State var viewModel: AssetListViewModel = .init()
    var body: some View{
        NavigationStack{
            Text(viewModel.errorMessage ?? "")
            List{
                ForEach(viewModel.assets){ asset in
                    NavigationLink {
                        AssetDetailView(asset: asset)
                    } label: {
                        AssetView(assetViewState: .init(asset))
                    }
                    
                }
            }
            .listStyle(.sidebar)
            .task {
                await viewModel.fetchAssets()
            }
            .navigationTitle("Home")
        }
    
    }
}
#Preview {
    AssetList()
}
