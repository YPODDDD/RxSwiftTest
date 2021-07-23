//
//  UserListView.swift
//  RxSwiftTest
//
//  Created by Ypodddd on 7/23/21.
//

import UIKit
import SDWebImage

class UserListView: UIViewController {
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var userListTableView: UITableView!
    
    var user_list = [User]()
    
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
                self.user_list = result
                self.userListTableView.reloadData()
            }
        }
        textField.resignFirstResponder()
        return false
    }
}

extension UserListView: UITableViewDelegate, UITableViewDataSource {
    
    func setTableView() {
        userListTableView.delegate = self
        userListTableView.dataSource = self
        
        UserCell.register(for: userListTableView)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifierName, for: indexPath) as! UserCell
        let data = user_list[indexPath.row]
        cell.picture.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.picture.sd_setImage(with: URL(string: data.picture.thumbnail))
        cell.name.text = data.name.first + " " + data.name.last
//        cell.age.text = "อายุ: \(data.age)"
        cell.email.text = data.email
        return cell
    }
    
}
