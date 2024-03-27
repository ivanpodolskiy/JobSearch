//
//  SearchViewModel.swift
//  JobSearch
//
//  Created by user on 18.03.2024.
//
import Foundation
import Combine

class SearchViewModel {
    @Published var recommendations: [Recommendation] = []
    @Published var vacancies: [VacancyItem] = []
    
    private let jobsDataService: JobsFetcher
    private let favoriteStorage: FavoriteStorage
    
    private var cancellables = Set<AnyCancellable>()
    init(favoriteStorage: FavoriteStorage, jobsDataService: JobsFetcher) {
        self.favoriteStorage = favoriteStorage
        self.jobsDataService = jobsDataService

        favoriteStorage.$favoriteVacancies
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.vacancies = favoriteStorage.updateVacanciesFromAPI(vacancies)
            }
            .store(in: &cancellables)
        loadData()
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
                let vacancies = jobsItem.vacancies
                self.recommendations = jobsItem.recommendations
                self.vacancies = favoriteStorage.updateVacanciesFromAPI(vacancies)
            }
            .store(in: &cancellables)
    }
    
    func changeFavoriteStatus(id: String, isFavorite: Bool) {
        guard let index = vacancies.firstIndex(where: { $0.id == id }) else { return }
        
        switch isFavorite {
        case true:
            favoriteStorage.addFavoriteVacancy( vacancies[index])
        case false:
            favoriteStorage.removeFavoriteVacancy( vacancies[index])
        }
        vacancies[index].isFavorite = isFavorite
    }
}
