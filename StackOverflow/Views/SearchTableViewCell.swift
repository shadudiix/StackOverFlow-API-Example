//
//  SearchTableViewCell.swift
//  StackOverflow
//
//  Created by Shady K. Maadawy on 10/07/2022.
//

import UIKit
import TagListView

class SearchTableViewCell: UITableViewCell, TagListViewDelegate {

    @IBOutlet weak var ImgViewProfilePicture: UIImageView!
    @IBOutlet weak var LblUserName: UILabel!
    @IBOutlet weak var LblTitle: UILabel!
    @IBOutlet weak var LblCreationDate: UILabel!
    @IBOutlet weak var LblScore: UILabel!
    @IBOutlet weak var LblAnswers: UILabel!
    @IBOutlet weak var ImgViewIsAnswerd: UIImageView!
    @IBOutlet weak var LvTags: TagListView!
    var question_ID : Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        LvTags.delegate = self
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
