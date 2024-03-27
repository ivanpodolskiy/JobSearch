//
//  JobsDataService.swift
//  JobSearch
//
//  Created by user on 18.03.2024.
//

import Foundation
import Combine

protocol JobsFetcher {
    func fetchJobsData() -> AnyPublisher<JobDataModel, NetworkError>
}

final class JobsFetcherService: JobsFetcher{
    private let stringURL: String
    private var networkService: Networking
    
    init(networkService: Networking = NetworkingService()) {
        self.networkService = networkService
        self.stringURL = "https://run.mocky.io/v3/ed41d10e-0c1f-4439-94fa-9702c9d95c14"
    }
    
    func fetchJobsData() -> AnyPublisher<JobDataModel, NetworkError> {
        guard let url = URL(string: stringURL) else {
            return Fail(error: NetworkError.badURL)
                .eraseToAnyPublisher()
        }
        return networkService.sendRequest(from: url, decdoingType: JobDataAPI.self)
            .map { JobDataModel(from: $0)}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
