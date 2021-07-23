//
//  UserListView.swift
//  RxSwiftTest
//
//  Created by Ypodddd on 7/23/21.
//

import UIKit
import SDWebImage
import RxSwift
import RxRelay
import RxCocoa

class UserListView: UIViewController {
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var userListTableView: UITableView!
    
    var disposeBag = DisposeBag()
    
    var user_list = BehaviorRelay<[User]>(value: [])
    
    override func viewDidLoad() {
        setTextField()
        setTableView()
    }
    
}

extension UserListView: UITextFieldDelegate {
    func setTextField() {
        inputTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let input = textField.text {
            CustomAPI.shared.getUser(input: input) { result in
                guard let result = result else { return }
                self.user_list.accept(result)
                self.userListTableView.reloadData()
            }
        }
        textField.resignFirstResponder()
        return false
    }
}

extension UserListView: UIScrollViewDelegate {
    
    func setTableView() {
        
        userListTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        UserCell.register(for: userListTableView)
        
        user_list.asObservable()
                .bind(to: userListTableView.rx
                        .items(cellIdentifier: UserCell.identifierName, cellType: UserCell.self))
                { index, element, cell in
                    cell.picture.sd_imageIndicator = SDWebImageActivityIndicator.gray
                    cell.picture.sd_setImage(with: URL(string: element.picture.thumbnail))
                    cell.name.text = element.name.first + " " + element.name.last
                    cell.email.text = element.email
            }
            .disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
