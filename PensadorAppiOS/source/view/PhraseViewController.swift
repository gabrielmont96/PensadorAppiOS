//
//  FraseViewController.swift
//  PensadorAppiOS
//
//  Created by Gabriel Silva on 22/03/19.
//  Copyright © 2019 Gabriel Silva. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseInstanceID

class PhraseViewController: UIViewController {

    var presenter: PhrasePresenter?
    var param = ""
    var phrases: [Phrase]? = []
    var phraseSelected: Phrase?
    var page = 1
    var titleMainView: String?
    var alreadyPassed: Bool = false
    var fromCategory = false
    var fromSearch = false
    var loading: Loading?
    var phraseTwo: [Phrase] = []
    
    @IBOutlet weak var lblTitle: UILabel?
    @IBOutlet weak var tableView: UITableView? {
        didSet {
            tableView?.delegate = self
            tableView?.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PhrasePresenter(self)
        
        let button = UIBarButtonItem(image: UIImage(named: "unfavorite"), style: .plain, target: self, action: #selector(test))
        navigationItem.rightBarButtonItem = button
        
        if fromCategory {
            presenter?.getPrasesCategoryResult(param: param, page: page)
        }
        
        if fromSearch {
            presenter?.getSearchResult(param: param, page: page)
        }
        
        loading = Loading(frame: self.view.frame, center: self.view.center)
        
        if let lndg = loading {
            self.view.addSubview(lndg)
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let titleFromMainView = titleMainView {
            lblTitle?.text = titleFromMainView
        } else {
            lblTitle?.text = param
        }
    }
    
    
    @objc func test() {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhraseViewController") as? PhraseViewController {
   
            
            
                InstanceID.instanceID().instanceID { (result, error) in
                    if let error = error {
                        print("Error fetching remote instange ID: \(error)")
                    } else if let result = result {
                        let db = Firestore.firestore()
                        db.collection(result.token).getDocuments() { (snapshot, error) in
                            if let text = snapshot?.value(forKey: "text"), let imageUrl = snapshot?.value(forKey: "imageUrl") {
                                vc.phraseTwo.append(Phrase(text: text as! String, imageUrl: imageUrl as! String))
                            }
                        }
                    }
                }
            
            
            
            
            
            
            vc.navigationItem.rightBarButtonItem = nil
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func tapBtnCopy(sender: UIButton) {
        let buttonTag = sender.tag
        if let text = phrases?[buttonTag].text {
            UIPasteboard.general.string = text
            showToast(message: "Copied successfully!", mode: .success )
        } else {
            showToast(message: "Failed to copy, please try again!", mode: .error)
        }
    }
    
    @objc func tapBtnShare(sender: UIButton) {
        let buttonTag = sender.tag
        if let text = phrases?[buttonTag].text {
            let vc = UIActivityViewController(activityItems: [text], applicationActivities: [])
            present(vc, animated: true)
        }
    }
    
    @objc func tapBtnFavorite(sender: UIButton) {
        let buttonTag = sender.tag
        let indexPath = IndexPath(item: buttonTag, section: 0)
       
        if let phrase = phrases?[buttonTag] {
            InstanceID.instanceID().instanceID { (result, error) in
                if let error = error {
                    print("Error fetching remote instange ID: \(error)")
                } else if let result = result {
                    let db = Firestore.firestore()
                    if !(self.phrases?[buttonTag].favorite)! {
                        self.phrases?[buttonTag].favorite = true
                                print("Remote instance ID token: \(result.token)")
                        
                                db.collection(result.token).document().setData([
                                    "text": phrase.text ?? "",
                                    "imageUrl": phrase.imageUrl ?? "",
                                    "favorite": phrase.favorite
                                ]) { err in
                                    if let err = err {
                                        print("Error writing document: \(err)")
                                    } else {
                                        print("Document successfully written!")
                                    }
                                }
                    } else {
                        self.phrases?[buttonTag].favorite = false
                        db.collection(result.token).whereField("imageUrl", isEqualTo: phrase.imageUrl ?? "").getDocuments() { (querySnapshot, err) in
                            if let err = err {
                                print("Error getting documents: \(err)")
                            } else {
                                for document in querySnapshot!.documents {
                                    document.reference.delete()
                                }
                            }
                        }
                    }
                }
            }
        }
        tableView?.reloadRows(at: [indexPath], with: .automatic)
    }
}

extension PhraseViewController: UITableViewDelegate {}

extension PhraseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phrases?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = PhrasesCell.identifier
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? PhrasesCell {
            cell.prepareCell(phrases: phrases![indexPath.row])
            cell.btnCopy?.addTarget(self, action: #selector(tapBtnCopy(sender:)), for: .touchUpInside)
            cell.btnCopy?.tag = indexPath.row
            cell.btnShare?.addTarget(self, action: #selector(tapBtnShare(sender:)), for: .touchUpInside)
            cell.btnShare?.tag = indexPath.row
            cell.btnFavorite.addTarget(self, action: #selector(tapBtnFavorite(sender:)), for: .touchUpInside)
            cell.btnFavorite.tag = indexPath.row
            
            if (phrases?[indexPath.row].favorite)! {
                cell.btnFavorite.setImage(UIImage(named: "favorite"), for: .normal)
            } else {
                cell.btnFavorite.setImage(UIImage(named: "unfavorite"), for: .normal)
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (!alreadyPassed) {
            alreadyPassed = true
            UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
                self.loading?.alpha = 0.0
            }, completion: {(isCompleted) in
                self.tableView?.isHidden = false
                self.loading?.removeFromSuperview()
            })
        }
        
        if indexPath.item == tableView.numberOfRows(inSection: indexPath.section) - 3 {
            if fromCategory {
                presenter?.getPrasesCategoryResult(param: param, page: page+1)
            }
            if fromSearch {
                presenter?.getSearchResult(param: param, page: page+1)
            }
            page = page+1
        }
    }

    
}

extension PhraseViewController: PhraseDelegate {
    func onSuccessSearch(phrases: List) {
        print("")
        for item in phrases.list {
            self.phrases?.append(item)
            
        }
        tableView?.reloadData()
    }
    
    func onFailure(message: String?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.showToast(message: "Failed to request", mode: .error)
            self.loading?.removeFromSuperview()
            self.tableView?.isHidden = true
        }
    }
}
