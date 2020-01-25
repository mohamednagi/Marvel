//
//  MarvelDetailsView.swift
//  Marvel
//
//  Created by Sierra on 1/24/20.
//  Copyright © 2020 Nagiz. All rights reserved.
//

import UIKit

class MarvelDetailsView: UIViewController, BaseView {
    
    @IBOutlet weak var marvelImage: UIImageView!
    @IBOutlet weak var marvelName: UILabel!
    @IBOutlet weak var marvelDescription: UILabel!
    
    @IBOutlet weak var comicsList: UICollectionView!
    @IBOutlet weak var seriesList: UICollectionView!
    @IBOutlet weak var storiesList: UICollectionView!
    @IBOutlet weak var eventsList: UICollectionView!
    @IBOutlet weak var indicatorView: UIView!
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent;
    }
    
    
    var viewModel: DetailsViewModel!
    
    var detailLink = ""
    var wikiLink = ""
    var comicLink = ""
    var characterID = ""
    
    var comicsArray = [MarvelDetailsCellModel]()
    var seriesArray = [MarvelDetailsCellModel]()
    var storiesArray = [MarvelDetailsCellModel]()
    var eventsArray = [MarvelDetailsCellModel]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleNavBar()
        viewModel = DetailsViewModel(view:self)
        viewModel.getDetailsData(characterID: characterID)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func onDataRecieved(data: AnyObject) {
        indicatorView.isHidden = true
        guard let returnedData = data as? [MarvelDetailsModel] else {return}
        
        for returnedCharacter in returnedData {
            detailLink = returnedCharacter.detailLink
            wikiLink = returnedCharacter.wikiLink
            comicLink = returnedCharacter.comicLink
            let imageUrl = URL(string: returnedCharacter.marvelImage)
            marvelImage.kf.indicatorType = .activity
            marvelImage.kf.setImage(with: imageUrl)
            marvelName.text = returnedCharacter.marvelName
            marvelDescription.text = returnedCharacter.marvelDescription
            comicsArray = returnedCharacter.marvelComics
            seriesArray = returnedCharacter.marvelSeries
            storiesArray = returnedCharacter.marvelStories
            eventsArray = returnedCharacter.marvelEvents
            comicsList.reloadData()
            seriesList.reloadData()
            storiesList.reloadData()
            eventsList.reloadData()
        }
    }
    
    func handleNavBar() {
        navigationController?.navigationBar.barTintColor = .clear
        let backBTN = UIBarButtonItem(image: UIImage(named: "arrow"),
                                      style: .plain,
                                      target: navigationController,
                                      action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backBTN
    }
    
    @IBAction func openSafariAction(_ sender: UIButton) {
        
        var destination = ""
        switch sender.tag {
        case 0: // detail
            destination = detailLink
        case 1: // wiki
            destination = wikiLink
        default:    // comic
            destination = comicLink
        }
        print(destination)
        guard let url = URL(string: destination) else { return }
        UIApplication.shared.open(url)
    }
    
    
    
}
