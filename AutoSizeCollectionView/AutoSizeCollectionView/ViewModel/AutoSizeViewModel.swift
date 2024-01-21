//
//  AutoSizeViewModel.swift
//  AutoSizeCollectionView
//
//  Created by Arjun Mohan on 21/01/24.
//

import Foundation
import UIKit

class AutoSizeViewModel {
    // MARK: - PROPERTIES
    var firstCellFrame: CGRect = .zero
    var secondCellFrame: CGRect = .zero
    var getSetFirstCellFrame: CGRect {
        get {
            return firstCellFrame
        }
        set(newValue) {
            firstCellFrame = newValue
        }
    }
    var getSetSecondCellFrame: CGRect {
        get {
            return secondCellFrame
        }
        set(newValue) {
            secondCellFrame = newValue
        }
    }
    
    // MARK: - HELPERS
    /// Function to get the label height
    /// - Parameters:
    ///   - text: label text in `String`
    ///   - collectionView: instance of `UICollectionView`
    /// - Returns: `CGSize` of the label
    func getLabelHeight(text: String, collectionView: UICollectionView) -> CGSize {
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 15)
        let labelSize = label.sizeThatFits(CGSize(width: (collectionView.frame.width - 20) / 2, height: CGFloat.greatestFiniteMagnitude))
        return labelSize
    }
    
    /// Function to calculate the current cell's frame
    /// - Parameters:
    ///   - index: index of the cell in `Int`
    ///   - cell: instance of `UICollectionViewCell`
    func calculateCellFrame(index: Int, cell: UICollectionViewCell) {
        switch index {
        case 0:
            cell.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
            firstCellFrame = cell.frame
        case 1:
            cell.frame = CGRect(x: firstCellFrame.maxX + 20, y: 0, width: cell.frame.width, height: cell.frame.height)
            secondCellFrame = cell.frame
        default:
            calculateCellPosition(firstFrame: firstCellFrame, secondFrame: secondCellFrame, cell: cell)
        }
    }
    
    /// Function to calculate the cell position
    /// - Parameters:
    ///   - firstFrame: frame of the first cell in `CGRect`
    ///   - secondFrame: frame of the second cell in `CGRect`
    ///   - cell: instance of `UICollectionViewCell`
    private func calculateCellPosition(firstFrame: CGRect, secondFrame: CGRect, cell: UICollectionViewCell) {
        if firstFrame.maxY + 15 < secondFrame.maxY + 15 {
            cell.frame = CGRect(x: 0, y: firstFrame.maxY + 15, width: cell.frame.width, height: cell.frame.height)
            firstCellFrame = cell.frame
        } else {
            cell.frame = CGRect(x: firstFrame.maxX + 20, y: secondFrame.maxY + 15, width: cell.frame.width, height: cell.frame.height)
            secondCellFrame = cell.frame
        }
    }
}
