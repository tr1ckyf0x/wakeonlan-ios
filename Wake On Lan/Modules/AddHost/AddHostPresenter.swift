//
//  AddHostPresenter.swift
//  Wake On Lan
//
//  Created by Владислав Лисянский on 27.04.2020.
//  Copyright © 2020 Владислав Лисянский. All rights reserved.
//

import Foundation

class AddHostPresenter {
    weak var view: AddHostViewInput?
    
    var interactor: AddHostInteractorInput?
    
    var router: AddHostRouter?
    
    private(set) var tableManager = AddHostTableManager()
    
    private var addHostForm = AddHostForm()
}

extension AddHostPresenter: AddHostViewOutput {
    func viewDidLoad(_ view: AddHostViewInput) {
        tableManager.form = addHostForm
        view.reloadTable()
    }
    
    func viewDidPressSaveButton(_ view: AddHostViewInput) {
        // TODO: Обработка ошибок формы
        guard addHostForm.isValid else { return }
        interactor?.saveForm(addHostForm)
    }
}

extension AddHostPresenter: AddHostInteractorOutput {
    func interactor(_ interactor: AddHostInteractorInput, didSaveForm form: AddHostForm) {
        router?.popCurrentController(animated: true)
    }
}