//
//  FavoriteStorage.swift
//  JobSearch
//
//  Created by user on 18.03.2024.
//

import Combine

class FavoriteStorage {
    @Published var favoriteVacancies: [VacancyItem] = []
    
    func addFavoriteVacancy(_ vacancy: VacancyItem) {
        if favoriteVacancies.contains(where: { vacancyItem in
            vacancyItem.id == vacancy.id
        }) == false {
            var updatedVacancy = vacancy
            updatedVacancy.isFavorite = true
            favoriteVacancies.append(vacancy)
        }
    }
    
    func removeFavoriteVacancy(_ vacancy: VacancyItem) {
        favoriteVacancies.removeAll { $0.id == vacancy.id }
    }
    
    func updateVacanciesFromAPI(_ vacancies: [VacancyItem]) -> [VacancyItem] {
         var updatedVacancies: [VacancyItem] = []
         for var vacancy in vacancies {
             if let _ = favoriteVacancies.firstIndex(where: { $0.id == vacancy.id }) {
                 vacancy.isFavorite = true
             }
             updatedVacancies.append(vacancy)
         }
         return updatedVacancies
     }
}
