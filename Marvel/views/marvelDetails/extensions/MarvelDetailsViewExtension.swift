//
//  MarvelDetailsViewExtension.swift
//  Marvel
//
//  Created by Sierra on 1/24/20.
//  Copyright © 2020 Nagiz. All rights reserved.
//

import UIKit

extension MarvelDetailsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case comicsList:
            return comicsArray.count
        case seriesList:
            return seriesArray.count
        case storiesList:
            return storiesArray.count
        default:
            return eventsArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case comicsList:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComicsCell", for: indexPath) as? ComicsCell else {return UICollectionViewCell()}
            cell.comicName.text = comicsArray[indexPath.row].cellName
            cell.comicImage.layer.cornerRadius = 5
            let url = URL(string: (comicsArray[indexPath.row].cellImage))
            cell.comicImage?.kf.indicatorType = .activity
            cell.comicImage?.kf.setImage(with: url)
            return cell
        case seriesList:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeriesCell", for: indexPath) as? SeriesCell else {return UICollectionViewCell()}
            cell.seriesName.text = seriesArray[indexPath.row].cellName
            cell.seriesImage.layer.cornerRadius = 5
            let url = URL(string: (seriesArray[indexPath.row].cellImage))
            cell.seriesImage?.kf.indicatorType = .activity
            cell.seriesImage?.kf.setImage(with: url)
            return cell
        case storiesList:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoriesCell", for: indexPath) as? StoriesCell else {return UICollectionViewCell()}
            cell.storyName.text = storiesArray[indexPath.row].cellName
            cell.storyImage.layer.cornerRadius = 5
            let url = URL(string: (storiesArray[indexPath.row].cellImage))
            cell.storyImage?.kf.indicatorType = .activity
            cell.storyImage?.kf.setImage(with: url)
            return cell
            
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventsCell", for: indexPath) as? EventsCell else {return UICollectionViewCell()}
            cell.eventName.text = eventsArray[indexPath.row].cellName
            cell.eventImage.layer.cornerRadius = 5
            let url = URL(string: (eventsArray[indexPath.row].cellImage))
            cell.eventImage?.kf.indicatorType = .activity
            cell.eventImage?.kf.setImage(with: url)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.3, height: 180)
    }
    
    
}
