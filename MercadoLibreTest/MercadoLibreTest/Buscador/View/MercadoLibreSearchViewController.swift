//
//  MercadoLibreSearchViewController.swift
//  MercadoLibreTest
//
//  Created by c08712 on 05/02/2021.
//

import UIKit

class MercadoLibreSearchViewController: UIViewController {

    @IBOutlet weak var searchScrollView: UIScrollView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var service: MercadoLibreSearchService?
    var viewmodel: MercadoLibreSearchViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        
        searchBar.delegate = self
        service = MercadoLibreSearchService()
        viewmodel = MercadoLibreSearchViewModel()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = ""
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func configureView() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(closeKeyboardType))
        self.view.addGestureRecognizer(gesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        //Scrolls up when keyboard is open
        let userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        if keyboardFrame.height > getSearchBarHeight() {
            var contentInset:UIEdgeInsets = self.searchScrollView.contentInset
            contentInset.bottom = keyboardFrame.size.height
            searchScrollView.contentInset = contentInset
            searchScrollView.setContentOffset(CGPoint(x: 0, y: keyboardFrame.size.height), animated: true)
        }
    }
   
    @objc func closeKeyboardType() {
        //Scrolls down when keyboard is open
        searchScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        self.view.endEditing(true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? MercadoLibreListViewController else { return }
        viewController.searchItem = sender as? String
        viewController.title = sender as? String
    }
    
    func getSearchBarHeight() -> CGFloat {
        return self.view.frame.height - searchBar.frame.origin.y - searchBar.frame.height
    }
}

extension MercadoLibreSearchViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewmodel?.validateSearch(search: searchBar.text ?? "", completion: { (completion) in
            switch completion {
            case .success():
                self.performSegue(withIdentifier: "go_to_result_list", sender: searchBar.text)
                
            case .failure(let error):
                guard let navigationController = self.navigationController else { return }
                Utils.showAlert(controller: navigationController, title: "", message: error.getErrorDescription(), alertAction: {})
            }
        })
        
    }
}
