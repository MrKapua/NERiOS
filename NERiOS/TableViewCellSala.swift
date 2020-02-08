//
//  TableViewCellSala.swift
//  NERiOS
//
//  Created by José Jiménez Asensio on 01/02/2020.
//  Copyright © 2020 José Jiménez Asensio. All rights reserved.
//

import UIKit

class TableViewCellSala: UITableViewCell
{

    @IBOutlet weak var lbl_nombre: UILabel!
    @IBOutlet weak var lbl_personas: UILabel!
    @IBOutlet weak var lbl_tematica: UILabel!
    @IBOutlet weak var lbl_precio: UILabel!
    @IBOutlet weak var lbl_ref: UILabel!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }

}
