//
//  HomeVC.swift
//  SportsApp
//
//  Created by albaraa alsayed on 06/12/1447 AH.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var languageBarButton: UIBarButtonItem!
    var isEnglish: Bool = true
    
    
    let sportsList: [SportType] = [.football, .basketball, .cricket, .tennis]
    var sportType: SportType = .football
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib(nibName: "SportsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
    
    
    @IBAction func didTapLocalizationButton(_ sender: Any) {
        let currentLanguage = UserDefaultsManager.shared.getLanguage() ?? "en"
        let newLanguage = (currentLanguage == "en") ? "ar" : "en"
        
        UserDefaultsManager.shared.changeLanguage(to: newLanguage)
        UserDefaults.standard.set([newLanguage], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        
        let message = (newLanguage == "ar") ? "سيتم إغلاق التطبيق الآن لتطبيق اللغة الجديدة. يرجى فتحه مرة أخرى." : "The app will now close to apply the new language. Please reopen it."
        let title = (newLanguage == "ar") ? "تغيير اللغة" : "Change Language"
        
        AlertManager.showLanguageChangeAlert(on: self, title: title, message: message)
    }
    
    @IBAction func didTapSystemTheme(_ sender: Any) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                windowScene.windows.forEach { window in
                    window.overrideUserInterfaceStyle = .unspecified
                }
            }
            UserDefaultsManager.shared.changeTheme(to: "system")
        }
    
    @IBAction func didTapDarkTheme(_ sender: Any) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
        }
        UserDefaultsManager.shared.changeTheme(to: "dark")
    }
    
    @IBAction func didTapLightTheme(_ sender: Any) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }
        }
        UserDefaultsManager.shared.changeTheme(to: "light")
    }
    
}

extension HomeVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SportsCollectionViewCell
        
        let currentSport = sportsList[indexPath.item]
        
        switch currentSport {
        case .football:
            cell.image.image = UIImage(named: "football")
            cell.sportLabel.text = NSLocalizedString("Football", comment: "")
        case .basketball:
            cell.image.image = UIImage(named: "basketball")
            cell.sportLabel.text = NSLocalizedString("Basketball", comment: "")
        case .cricket:
            cell.image.image = UIImage(named: "cricket")
            cell.sportLabel.text = NSLocalizedString("Cricket", comment: "")
        case .tennis:
            cell.image.image = UIImage(named: "tennis")
            cell.sportLabel.text = String(localized:"Tennis", comment: "")
        }
        return cell
    }
}

extension HomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        sportType = sportsList[indexPath.item]
        
        NetworkConnection.shared.isOnline(on: self) {
            let sb = UIStoryboard(name: Constants.leaguesVC, bundle: nil)
            let vc = sb.instantiateViewController(identifier: Constants.leaguesVC) { [weak self] coder in
                guard let self else { return UIViewController(nibName: nil, bundle: nil) }
                return LeaguesVC(coder: coder, sportType: self.sportType)
            }
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let totalWidthSpacing: CGFloat = 30
        let totalWidth = collectionView.bounds.width - totalWidthSpacing
        let widthPerItem = floor(totalWidth / 2) - 1
        
        let totalHeightSpacing: CGFloat = 30
        let totalHeight = collectionView.bounds.height - totalHeightSpacing
        let heightPerItem = floor(totalHeight / 2) - 1
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
}
