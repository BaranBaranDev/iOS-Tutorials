//
//  DetailPresenter.swift
//  VIP-Architecture
//
//  Created by Baran Baran on 19.05.2024.
//


import UIKit

protocol DetailPresentationLogic
{
  func presentSomething(response: Detail.Something.Response)
}

class DetailPresenter: DetailPresentationLogic
{
  weak var viewController: DetailDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: Detail.Something.Response)
  {
    let viewModel = Detail.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
