//
//  TableViewCellEmpresa.swift
//  NERiOS
//
//  Created by José Jiménez Asensio on 18/01/2020.
//  Copyright © 2020 José Jiménez Asensio. All rights reserved.
//

import UIKit

class TableViewCellEmpresa: UITableViewCell {

    @IBOutlet weak var lbl_nombre: UILabel!
    @IBOutlet weak var lbl_ciudad: UILabel!
    @IBOutlet weak var lbl_provincia: UILabel!
    @IBOutlet weak var lbl_uid: UILabel!
    @IBOutlet weak var img_empresa: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
