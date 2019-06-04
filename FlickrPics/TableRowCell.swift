//
//  Copyright © 2019 News UK. All rights reserved.
//

import UIKit

class TableRowCell: UITableViewCell {


    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
