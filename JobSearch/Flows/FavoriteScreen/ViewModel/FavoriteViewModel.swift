//
//  FavoriteViewModel.swift
//  JobSearch
//
//  Created by user on 18.03.2024.
//

import Foundation
import Combine

class FavoriteViewModel {
    private var cancellables = Set<AnyCancellable>()
    @Published var favoriteVacancies: [VacancyItem] = []
    private let jobsDataService: JobsFetcherService
    private var favoriteStorage: FavoriteStorage
    
    init(favoriteStorage: FavoriteStorage, jobsDataService: JobsFetcherService) {
        self.favoriteStorage = favoriteStorage
        self.jobsDataService = jobsDataService
        loadData()
        
        favoriteStorage.$favoriteVacancies
            .sink { [weak self] vacancyItems in
                guard let self = self else { return }
                self.favoriteVacancies = vacancyItems
            }
            .store(in: &cancellables)
        loadData()
    }
    
    func removeFromFavorite(id: String) {
        guard let index = favoriteVacancies.firstIndex(where: { $0.id == id }) else { return }
        favoriteStorage.removeFavoriteVacancy( favoriteVacancies[index])
    }
    
    private func loadData() {
        jobsDataService.fetchJobsData()
            .sink { result in
                switch result {
                case .failure(let error):
                    print("Failed to fetch news: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] jobsItem in
                guard let self = self else { return }
                jobsItem.vacancies.forEach { vacancyItem in
                    if vacancyItem.isFavorite == true {
                        self.favoriteStorage.addFavoriteVacancy(vacancyItem)
                    }
                }
            }
            .store(in: &cancellables)
    }
}
