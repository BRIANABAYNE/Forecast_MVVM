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
    
    var forcastData: TopLevelDictionary?

    // step 3
    var days: [Day]  { //SOT
        self.forcastData?.days ?? [] // nil
    }
    weak var delegate: DayDetailViewDelegate?
    private let networkingController: NetworkingController
    
    init(delegate: DayDetailViewDelegate?, networkingController: NetworkingController = NetworkingController()) {
        self.delegate = delegate
        self.networkingController = networkingController
        fetchForcastData()
    }
        
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
    }// end of class for fetchForcastData
} // ending class

