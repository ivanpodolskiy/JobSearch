//
//  JobDataModel.swift
//  JobSearch
//
//  Created by user on 18.03.2024.
//

import Foundation

struct JobDataModel {
    let recommendations: [Recommendation]
    let vacancies: [VacancyItem]

    init(from jobDataAPI: JobDataAPI ) {
        self.recommendations = jobDataAPI.offers.map({ offer in
            Recommendation(form: offer)
        })
        self.vacancies = jobDataAPI.vacancies.map({ vacancy in
            VacancyItem(from: vacancy)
        })
    }
}

struct Recommendation {
    let title: String
    let id: String?
    let link: String
    let action: String?
    
    init(form offerAPI: Offer) {
        self.title = offerAPI.title
        self.id = offerAPI.id
        self.link = offerAPI.link
        self.action = offerAPI.button?.text
    }
}

struct VacancyItem {
    let id: String
    
    let company: String
    let description: String?
    
    var isFavorite: Bool
    let publishedDate: String
    let questions: [String]
    let address: String
    
    let vacancyDetail: VacancyDetail
    let lookingAppliedNumber: LookingAppliedNumber?
    
    init(from vacancyAPI: Vacancy) {
        self.id = vacancyAPI.id
        self.company = vacancyAPI.company
        self.description = vacancyAPI.description
        self.isFavorite = vacancyAPI.isFavorite
        self.publishedDate = vacancyAPI.publishedDate
        self.questions = vacancyAPI.questions
        self.address = "\(vacancyAPI.address.town), \(vacancyAPI.address.street), \(vacancyAPI.address.house)"
        
        let schedules = vacancyAPI.schedules.map { $0.capitalized }.joined(separator: ", ")
        
        self.vacancyDetail = VacancyDetail(title: vacancyAPI.title, experience: vacancyAPI.experience.previewText, responsibilities: vacancyAPI.responsibilities, schedules: schedules, salary: vacancyAPI.salary.short)
        
        self.lookingAppliedNumber = LookingAppliedNumber(lookingNumber: vacancyAPI.lookingNumber, appliedNumber: vacancyAPI.appliedNumber)
    }
}

struct LookingAppliedNumber {
    let lookingNumber: Int?
    let appliedNumber: Int?
}

struct VacancyDetail {
    let title: String
    let experience: String
    let responsibilities: String
    let schedules: String
    let salary: String?
}
