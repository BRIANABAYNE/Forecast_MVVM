//
//  DayDetailViewModel.swift
//  Forecast_MVVM
//
//  Created by Briana Bayne on 6/27/23.
//

import Foundation


protocol DayDetailViewDelegate: DayDetailsViewController {
    func updateView()
}

class DayDetailViewModel {

    // MARK: - Properties
    var forcastData: TopLevelDictionary?
    var days: [Day]  { 
        self.forcastData?.days ?? []
    }
    
    weak var delegate: DayDetailViewDelegate?
    private let networkingController: NetworkingController
    
    // MARK: - Dependency Injection
    init(delegate: DayDetailViewDelegate?, networkingController: NetworkingController = NetworkingController()) {
        self.delegate = delegate
        self.networkingController = networkingController
        fetchForcastData()
    }
    
    // MARK: - Functions
    private func fetchForcastData()  {
        NetworkingController.fetchDays { [weak self] result  in
            switch result {
            case .success(let forcastData):
                self?.forcastData = forcastData
                self?.delegate?.updateView()
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
