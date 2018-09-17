//
//  HoroscopeVC.swift
//  HoroscopeModule
//
//  Created by Varun Dudeja on 16/09/18.
//  Copyright © 2018 Varun Dudeja. All rights reserved.
//

import UIKit

protocol HoroscopePresenterLogic: class {
    func getUserHoroscopeDetails(_ response: HoroscopeResponse?, selectedIndex: Int)
}

class HoroscopeVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    var response: HoroscopeResponse?
    var presenter: HoroscopePresenterLogic?
    var datasource: [[Any]] = []
    private var collectionGrids: [Grid] = []
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupConfiguration()
    }
    
    private func setupConfiguration() {
        let presenter = HoroscopePresenter()
        presenter.displayLogic = self
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initializeView()
        presenter?.getUserHoroscopeDetails(response, selectedIndex: 0)
    }
    
    private func initializeView() {
        
        tableView.register(UINib(nibName: "HoroscopeTitleCell", bundle: nil), forCellReuseIdentifier: "HoroscopeTitleCell")
        tableView.register(UINib(nibName: "TalkToExpertCell", bundle: nil), forCellReuseIdentifier: "TalkToExpertCell")
        tableView.register(UINib(nibName: "HoroscopeSectionCell", bundle: nil), forCellReuseIdentifier: "HoroscopeSectionCell")
        tableView.register(UINib(nibName: "TableViewCollectionCell", bundle: nil), forCellReuseIdentifier: "TableViewCollectionCell")
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        
        tableView.backgroundColor = #colorLiteral(red: 0.5787474513, green: 0.3215198815, blue: 0, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension HoroscopeVC: HoroscopeDisplayLogic {
    func displayDatasource(items: [[Any]]) {
        datasource = items
        tableView.reloadData()
    }
}

//MARK: - TableView Datasource Conformance

extension HoroscopeVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let viewModel = datasource[indexPath.section][indexPath.row]
        
        if let viewModel = viewModel as? HoroscopeTitleViewModel {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HoroscopeTitleCell", for: indexPath) as! HoroscopeTitleCell
            cell.delegate = self
            cell.updateUserInteface(viewModel: viewModel, selectedIndex: viewModel.selectedIndex)
            
            return cell
        } else if let viewModel = viewModel as? HoroscopeSectionViewModel {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HoroscopeSectionCell", for: indexPath) as! HoroscopeSectionCell
            cell.updateUserInterface(viewModel: viewModel)
            return cell
        } else if let viewModel = viewModel as? TalkToExpertViewModel {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TalkToExpertCell", for: indexPath) as! TalkToExpertCell
            cell.updateUserInterface(viewModel: viewModel)
            return cell
        } else {
            collectionGrids = viewModel as! [Grid]
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCollectionCell", for: indexPath) as! TableViewCollectionCell
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            
            cell.collectionView.reloadData()
            let height = cell.collectionView.collectionViewLayout.collectionViewContentSize.height
            cell.heightConstraint.constant = height
            
            return cell
        }
    }
}

//MARK: - TableView Delegate Conformance

extension HoroscopeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section != 0 {
            return 20
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section != 0 {
            let vw = UIView(frame: CGRect.init(x: 0, y: 0, width: 100, height: 20))
            vw.backgroundColor = #colorLiteral(red: 0.5787474513, green: 0.3215198815, blue: 0, alpha: 1)
            return vw
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}

//MARK: - Title Cell Delegate Conformance

extension HoroscopeVC: HoroscopeTitleCellDelegate {
    func selectedZodiacSegment(_ zodiacSegment: HoroscopeSegment, index: Int) {
        presenter?.getUserHoroscopeDetails(response, selectedIndex: index)
    }
}

//MARK: - Collection Datasource

extension HoroscopeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionGrids.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as! GridCell
        cell.updateUserInterface(viewModel:  collectionGrids[indexPath.row])
        return cell
    }
}

//MARK: - Collection Delegate

extension HoroscopeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.bounds.width - 34) / 3
        return CGSize(width: width, height: 60)
    }
}
