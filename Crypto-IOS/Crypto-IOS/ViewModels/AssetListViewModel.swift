import Foundation
import Dependencies

@Observable
final class AssetListViewModel{
    
    var errorMessage: String?
    var assets: [Asset] = []
    @ObservationIgnored
    @Dependency(\.assetsApiClient) var apiClient
    
    func fetchAssets() async {
        do {
            assets = try await apiClient.fetchAllAssets()
        } catch let error as NetworkingError {
            errorMessage = error.localizedDescription
        }catch {
            errorMessage = error.localizedDescription
        }
        
//    func fetchAssets()async{
//        let urlSession = URLSession.shared
//        
//        guard let url = URL(string:
//                                "https://4ff399d1-53e9-4a28-bc99-b7735bad26bd.mock.pstmn.io/v3/assets") else{
//            errorMessage = "Invalid URL"
//            return
//        }
//        
//        
//        do{
//            let(data, _) = try await urlSession.data(for : URLRequest(url: url))
//            let assetsResponse = try JSONDecoder().decode(AssetsResponse.self,
//                                                  from: data)
//            assets = assetsResponse.data
//        
//        } catch {
//            print(error.localizedDescription)
//            errorMessage = error.localizedDescription
//        }
    }
}
