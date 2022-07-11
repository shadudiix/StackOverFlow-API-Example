//
//  SearchViewController.swift
//  StackOverflow
//
//  Created by Shady K. Maadawy on 09/07/2022.
//

import UIKit
import Kingfisher
import SafariServices

class SearchController:  UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, SFSafariViewControllerDelegate{
    
    @IBOutlet weak var LblHelloWorld: UILabel!
    var Components : Home_Components = .Hello_World
    var Search_Items : [QuestionModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TxtSearch.delegate = self
        TblSearch.delegate = self
        TblSearch.dataSource = self
        ConfigureScreen()
    }
  

    @IBOutlet weak var TxtSearch: UISearchBar!
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if (searchBar.text?.isEmpty == false) {
            Search_Items.removeAll()
            ConfigureScreen(Components: .Search)
            NetworkManager.shared.fetchQuestions(Title: searchBar.text!) { [weak self] Quetions, Status in // Use weak reference to prevent Memory Leak if the user close the screen after the task has been finished
                guard let self = self else { return }
                DispatchQueue.main.async {
                    if(Status == true) {
                        if(Quetions.count == 0) {
                            Helper.shared.ShowDialog(Title: "No results were found", Message: "Check what you are looking for and try again.", Parent: self)
                            self.ConfigureScreen(Components: .Hello_World)
                        } else {
                            self.Search_Items.append(contentsOf: Quetions)
                            self.TblSearch.reloadData()
                            self.ConfigureScreen(Components: .Result)
                        }
                    } else {
                        Helper.shared.ShowDialog(Title: "An error occurred", Message: "An error occurred while processing your request, please check your internet connection and retry again.", Parent: self)
                        self.ConfigureScreen(Components: .Hello_World)
                    }
                }
            }
        }
    }

    @IBOutlet weak var TblSearch: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Search_Items.count
    }
    
    /// Row Get Selected, open it in safari view controller
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let SearchItem = Search_Items[indexPath.row]
        if let Url = URL(string: "https://stackoverflow.com/questions/\(String(SearchItem.question_id))") {
            let SfConfiguration = SFSafariViewController.Configuration()
            let SfViewController = SFSafariViewController(url: Url, configuration: SfConfiguration)
            present(SfViewController, animated: true)
        }
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true)
    }
    
    /// Build Tabel Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell_Search", for: indexPath) as! SearchTableViewCell
        let SearchItem = Search_Items[indexPath.row]
        if let url = SearchItem.owner.profile_image {
            let url = URL(string: url)
            cell.ImgViewProfilePicture.kf.setImage(with: url)
        }
        cell.LblUserName.text = SearchItem.owner.display_name
        cell.LblTitle.text = SearchItem.title
        if(SearchItem.is_answered == false) {
            cell.ImgViewIsAnswerd.image = UIImage(systemName: "xmark.circle.fill")
            cell.ImgViewIsAnswerd.tintColor = UIColor.red
        }
        cell.LblCreationDate.text = "Creation Date: " + Helper.shared.FixUnixDate(UinxDate: SearchItem.creation_date)
        cell.LblScore.text = " Score: " + String(SearchItem.score)
        cell.LblAnswers.text = " Answers: " + String(SearchItem.answer_count ?? 0)
        cell.question_ID = SearchItem.question_id
        cell.LvTags.removeAllTags() // there is a bug in this pod, it's repeat everything in every cell, so I fixed it with this simple solution
        cell.LvTags.addTags(SearchItem.tags)
        return cell
    }
    
    @IBOutlet weak var IndicatorLoading: UIActivityIndicatorView!
    
    func ConfigureScreen(Components : Home_Components = .Hello_World) {
        self.Components = Components
        switch self.Components {
            case .Hello_World :
                TxtSearch.EnableUserInteraction()
                TblSearch.Hide()
                IndicatorLoading.Hide()
                LblHelloWorld.Show()
            break
            case .Search :
                TblSearch.Hide()
                LblHelloWorld.Hide()
                IndicatorLoading.Show()
                TxtSearch.DisableUserInteraction()
            break
            case .Result :
                TblSearch.Show()
                LblHelloWorld.Hide()
                IndicatorLoading.Hide()
                TxtSearch.EnableUserInteraction()
            break
        }
    }
}
