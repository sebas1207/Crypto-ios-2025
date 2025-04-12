import Dependencies
import Foundation

struct AssetsApiClient{
    var fetchAllAssets: () async throws -> [Asset]
}

enum NetworkingError: Error {
    case invalidURL
}
extension AssetsApiClient: DependencyKey {
    static var liveValue: AssetsApiClient {
        .init(fetchAllAssets: {
            let urlSession = URLSession.shared
            guard let url = URL(string: "https://4ff399d1-53e9-4a28-bc99-b7735bad26bd.mock.pstmn.io/v3/assets") else {
                throw NetworkingError.invalidURL
            }
            let (data, _) = try await urlSession.data(for: URLRequest(url: url))
            let assetResponse = try JSONDecoder().decode(AssetsResponse.self, from: data)
            return assetResponse.data
            
        })
    }
    static var previewValue: AssetsApiClient {
        .init(fetchAllAssets:{[
            .init(
                id: "bitcoin", name: "Bitcoin", symbol: "BTC", priceUsd: "989785459.598", changePercent24Hr: "8.9944"
            ),
            .init(
                id: "ethereum", name: "Bitcoin", symbol: "ETH", priceUsd: "989785459.598", changePercent24Hr: "-8.9944"
            )
        ]}
        )
    }
    static var testValue: AssetsApiClient{
        .init(fetchAllAssets: {
            reportIssue("AssetsApiClient.fetchAllassets is unimplement")
            return[]
        })
    }
}
extension DependencyValues {
    var assetsApiClient : AssetsApiClient {
        get { self[AssetsApiClient.self]}
        set { self[AssetsApiClient.self] = newValue}
    }
}
