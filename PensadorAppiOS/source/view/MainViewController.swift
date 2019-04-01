//
//  ViewController.swift
//  PensadorAppiOS
//
//  Created by Gabriel Silva on 21/03/19.
//  Copyright © 2019 Gabriel Silva. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var vwLoading: UIView?
    @IBOutlet weak var activityLoading: UIActivityIndicatorView?
    @IBOutlet weak var tfSearch: UITextField?
    @IBOutlet weak var tableView: UITableView?
    var presenter: MainPresenter?
    var category: [Thinker] = []
    var selectedRowIndex: Int?
    var vwBgSearch: UIView?
    var alreadyPassed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainPresenter(self)
        
        presenter?.getCategory()
        tfSearch?.delegate = self
        
        activityLoading?.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        vwBgSearch = UIView(frame: CGRect(x: 0, y: 160, width: 414, height: 735))
        vwBgSearch?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        let tap = UITapGestureRecognizer(target: self, action: #selector(endSearch))
        vwBgSearch?.isUserInteractionEnabled = true
        vwBgSearch?.addGestureRecognizer(tap)
        vwBgSearch?.alpha = 0
        view.addSubview(vwBgSearch ?? UIView())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        endSearch()
    }
    
    @IBAction func goSearchPage(_ sender: Any) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FrasesViewController") as? PhraseViewController {
            if let text = tfSearch?.text, text != "" {
                vc.param = text
                vc.fromSearch = true
                navigationController?.pushViewController(vc, animated: true)
            } else {
                showToast(message: "Empty field is not allowed!", mode: .error)
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.vwBgSearch?.alpha = 1
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        endSearch()
        return true
    }
    
    @objc func endSearch() {
        UIView.animate(withDuration: 0.3) {
            self.vwBgSearch?.alpha = 0
        }
        view.endEditing(true)
        self.tfSearch?.text = ""
    }
}

extension MainViewController: UITableViewDelegate {
    
}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return category.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = CategoryCell.identifier
        if tableView.tag == 100 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CategoryCell {
                cell.listCat = category[indexPath.row].listCat
                cell.setup(category: category[indexPath.row])
                if category[indexPath.row].opened {
                    cell.imgExpand?.image = UIImage(named: "expand_less")
                } else {
                    cell.imgExpand?.image = UIImage(named: "expand_more")
                }
                cell.delegateSend = self
                cell.insideTableView?.reloadData()
                
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if category[indexPath.row].opened {
            category[indexPath.row].opened = false
        } else {
            category[indexPath.row].opened = true
        }
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.fade)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if category[indexPath.row].opened {
            return CGFloat((category[indexPath.row].listCat.count * 44) + 55)
        } else {
            return 55
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (!alreadyPassed) {
            alreadyPassed = true
            UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
                self.vwLoading?.alpha = 0.0
            }, completion: {(isCompleted) in
                self.vwLoading?.removeFromSuperview()
            })
        }
    }
    
}

extension MainViewController: ThinkerDelegate {
    func onSuccessSearch(category: [Thinker]) {
        return
    }
    
    func onSuccessCategories(category: [Thinker]) {
        self.category = category
        print ("success")
        self.tableView?.reloadData()
    }
    
    func onFailure(message: String?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.showToast(message: "Failed to request", mode: .error)
            self.vwLoading?.removeFromSuperview()
            self.tableView?.isHidden = true
        }
        print ("error")
    }
    
    
}

extension MainViewController: CallPhrasesDelegate {
    func callPhrasesInView(urlApi: String, title: String) {
       
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FrasesViewController") as? PhraseViewController {
            var text = urlApi
            text.removeFirst()
            text.removeLast()
            vc.param = text
            vc.fromCategory = true
            vc.titleMainView = title
            
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}

extension MainViewController: UITextFieldDelegate {}

