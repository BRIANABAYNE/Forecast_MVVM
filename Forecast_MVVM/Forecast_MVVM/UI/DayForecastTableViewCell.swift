//
//  DayForecastTableViewCell.swift
//  Forecast_MVVM
//
//  Created by Karl Pfister on 2/13/22.
//

import UIKit

class DayForcastTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var forcastedHighLabel: UILabel!
    
    // MARK: - Methods 
    func updateViews(day: Day) {
        dayNameLabel.text = day.validDate
        iconImageView.image = UIImage(named: day.weather.iconString)
        forcastedHighLabel.text = "\(day.highTemp)F"
    }
}
