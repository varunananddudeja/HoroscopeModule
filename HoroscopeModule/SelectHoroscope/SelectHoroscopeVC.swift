//
//  SelectHoroscopeVC.swift
//  HoroscopeModule
//
//  Created by Varun Dudeja on 16/09/18.
//  Copyright © 2018 Varun Dudeja. All rights reserved.
//

import UIKit

protocol SelectHoroscopePresenterLogic: class {
    func getSunsigns(from response: HoroscopeResponse?)
    func sunsignSelected(datasource: [SunsignCollectionViewModel], language: Int)
}

protocol SelectHoroscopeVCDelegate: class {
    func zodiacSelected(response: HoroscopeResponse?)
}

class SelectHoroscopeVC: BaseVC {
    
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var hindiBtn: UIButton!
    @IBOutlet weak var englishBtn: UIButton!
    var isHoroscopeTab = false
    var response: HoroscopeResponse?
    var datasource: [SunsignCollectionViewModel] = []
    var presenter: SelectHoroscopePresenterLogic?
    var selectedLanguage = 1 {
        didSet {
            if selectedLanguage == 1 {
                hindiBtn.isSelected = false
                englishBtn.isSelected = true
            } else {
                hindiBtn.isSelected = true
                englishBtn.isSelected = false
            }
        }
    }
    
    weak var delegate: SelectHoroscopeVCDelegate?
    
    @IBOutlet weak var collectionViewObj: UICollectionView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupConfiguration()
    }
    
    private func setupConfiguration() {
        let presenter = SelectHoroscopePresenter()
        presenter.displayLogic = self
        self.presenter = presenter
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
        // Do any additional setup after loading the view.
    }
    
    func initializeView() {
        
        addHeaderView()
        collectionViewObj.register(UINib.init(nibName: "SunsignCollectionCell", bundle: nil), forCellWithReuseIdentifier: "SunsignCollectionCell")
        presenter?.getSunsigns(from: response)
    }
    
    private func addHeaderView() {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        label.text = "Choose your Sunsign"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = #colorLiteral(red: 0.968627451, green: 0.5843137255, blue: 0.4392156863, alpha: 1)
        headerView.addSubview(label)
        collectionViewObj.addSubview(headerView)
        collectionViewObj.contentInset.top = 50
        
        headerView.frame = CGRect(x: 0, y: -50, width: collectionViewObj.frame.size.width, height: 50)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickedBtnEnglish(_ sender: Any) {
        selectedLanguage = 1
    }
    
    @IBAction func clickedBtnHindi(_ sender: Any) {
        selectedLanguage = 2
    }
    
    @IBAction func clickedBtnSubmit(_ sender: Any) {
        presenter?.sunsignSelected(datasource: datasource, language: selectedLanguage)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

//MARK: - CollectionView Datasource

extension SelectHoroscopeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SunsignCollectionCell", for: indexPath) as! SunsignCollectionCell
        cell.updateUserInterface(viewModel: datasource[indexPath.row])
        return cell
    }
}

//MARK: - CollectionView Delegate

extension SelectHoroscopeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        for item in datasource {
            item.selected = false
            
        }
        datasource[indexPath.row].selected = true
        collectionView.reloadData()
    }
}

extension SelectHoroscopeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ( view.bounds.width - 30 ) / 3
        return CGSize(width: width, height: width)
    }
}


extension SelectHoroscopeVC: SelectHoroscopeDisplayLogic {
    func displaySunsigns(list: [SunsignCollectionViewModel], selectedLanguage: Int) {
        datasource = list
        self.selectedLanguage = selectedLanguage
        collectionViewObj.reloadData()
    }
    
    func displaySuccessSubmission(response: HoroscopeResponse?) {
        delegate?.zodiacSelected(response: response)
    }
}
