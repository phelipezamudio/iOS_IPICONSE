//
//  AboutUsTab1ViewController.swift
//  IPI
//
//  Created by Felipe Zamudio on 06/05/19.
//  Copyright © 2019 NRC. All rights reserved.
//

import UIKit

class AboutUsTab1ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table_aboutNRC: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.table_aboutNRC.delegate = self
        self.table_aboutNRC.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - TableView delegate and datasource

    // Número de secciones de la tabla
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Número de filas
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    // Se agrega la propiedad para ajustar el tamaño de la celda al contenido
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    // Tamaño estimado de las celdas
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 478
    }

    // pintado de la tabla
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.aboutTab01Cell.rawValue, for: indexPath) as! AboutNRC1TableViewCell

        cell.fillCell()

        return cell
    }
}
