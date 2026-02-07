//
//  BranchListViewModel.swift
//  DonBigotes
//
//  Created by Franco Ruiz on 23/01/26.
//

import Foundation

class BranchListViewModel {
    private let branches: [Branch]
    
    var numberOfBranches: Int { branches.count }
    let title = "Branches"
    let cellIdentifier = "BranchCell"
    
    init(branches: [Branch]) {
        self.branches = branches
    }
    
    func branch(at indexPath: IndexPath) -> Branch {
        return branches[indexPath.row]
    }
}
