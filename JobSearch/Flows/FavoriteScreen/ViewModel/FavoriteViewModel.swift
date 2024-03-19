//
//  FavoriteModeView.swift
//  JobSearch
//
//  Created by user on 18.03.2024.
//

import Foundation
import Combine

class FavoriteModeView {
    private var cancellables = Set<AnyCancellable>()
    @Published var favoriteVacancies: [VacancyItem] = []
    
    private var favoriteStorage: FavoriteStorage
    private var previousFavoriteVacancies: [VacancyItem] = []
    
    init(favoriteStorage: FavoriteStorage) {
        self.favoriteStorage = favoriteStorage
        
        favoriteStorage.$favoriteVacancies
            .sink { [weak self] vacancyItems in
                guard let self = self else { return }
                // Устанавливаем новое значение
                self.favoriteVacancies = vacancyItems
                // Обновляем предыдущее значение
                self.previousFavoriteVacancies = vacancyItems
            }
            .store(in: &cancellables)
    }
    
    func removeFromFavorite(id: String) {
        guard let index = favoriteVacancies.firstIndex(where: { $0.id == id }) else { return }
        favoriteStorage.removeFavoriteVacancy( favoriteVacancies[index])
    }
}
