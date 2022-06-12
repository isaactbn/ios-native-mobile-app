//
//  BaseView.swift
//  NativeMobileApp
//
//  Created by Issac on 12/06/22.
//

protocol BaseView {
    func showError(msg: String)
    func onLoading()
    func onFinishLoading()
}

protocol ListView: BaseView {
    func onListEmpty()
}

extension ListView {
    func onListEmpty() {
        showError(msg: "Data Anda kosong")
    }
}
