//
//  ViewController.swift
//  MeteoriteRecordApp
//
//  Created by 李祺 on 27/02/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import UIKit

class MeteoriteListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    lazy var meteoriteVM: MeteoriteViewModel = {
         return MeteoriteViewModel()
     }()
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         initVM()
     }
     
     func initVM() {
         
         // Naive binding
         meteoriteVM.showAlertClosure = { [weak self] in
             DispatchQueue.main.async {
                 if let message = self?.meteoriteVM.alertMessage {
                     self?.showAlert(message)
                 }
             }
         }
         
         meteoriteVM.updateLoadingStatus = { [weak self] in
             DispatchQueue.main.async {
                 let isLoading = self?.meteoriteVM.isLoading ?? false
                 if isLoading {
                     self?.activityIndicator.startAnimating()
                     UIView.animate(withDuration: 0.2, animations: {
                         self?.tableView.alpha = 0.0
                     })
                 }else {
                     self?.activityIndicator.stopAnimating()
                     UIView.animate(withDuration: 0.2, animations: {
                         self?.tableView.alpha = 1.0
                     })
                 }
             }
         }
         
         meteoriteVM.reloadTableViewClosure = { [weak self] in
             DispatchQueue.main.async {
                 self?.tableView.reloadData()
             }
         }
         meteoriteVM.initFetch()
     }
    
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension MeteoriteListViewController: UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meteoriteVM.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mCell", for: indexPath) as? MeteoriteListCell else {
            fatalError("Cell not in storyboard")
        }
        
        let cellVM = meteoriteVM.getCellViewModel(at: indexPath)
        cell.meteoriteListCellViewModel = cellVM
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        self.meteoriteVM.userPressed(at: indexPath)
        if meteoriteVM.isSegueAllowed {
            return indexPath
        }else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MeteoriteListViewController{
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let vc = segue.destination as? MeteoriteDetailViewController,
                let selectedMeteorite = meteoriteVM.selectedMeteorite {
                vc.meteoriteDetailVM = MeteoriteDetailViewModel(meteorite: selectedMeteorite)
            }
        }
}
