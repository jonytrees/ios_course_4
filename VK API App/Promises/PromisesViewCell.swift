//
//  PromisesViewCell.swift
//  VK API App
//
//  Created by Евгений Янушкевич on 06.04.2021.
//

import UIKit

class PromisesViewCell: UITableViewCell {
    let insets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    
    @IBOutlet weak var firstNameLabel: UILabel! {
        didSet {
            firstNameLabel.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var imageFriends: UIImageView! {
        didSet {
            imageFriends.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    func setNameFriends(fullName: String, photo: UIImage?) {
        firstNameLabel.text = fullName
        imageFriends.image = photo
    }
    
    
    override var intrinsicContentSize: CGSize {
        return getCellSize(maxWidth: .greatestFiniteMagnitude)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        return getCellSize(maxWidth: size.width)
    }
    
    private func getCellSize(maxWidth: CGFloat) -> CGSize {
        let iconSize = iconViewSize()
        let nameLabelSize = getLabelSize(text: firstNameLabel.text!, font: firstNameLabel.font!, maxWidth: maxWidth)
        let totalWidth = nameLabelSize.width + iconSize.width + insets.left + insets.right + insets.left
        let totalHeight = iconSize.height + insets.top + insets.bottom
        let totalSize = CGSize(width: totalWidth, height: totalHeight)
        return totalSize
    }
    
    func getLabelSize(text: String, font: UIFont, maxWidth: CGFloat) -> CGSize {
        // определяем максимальную ширину текста - это ширина ячейки минус отступы слева и справа
        let maxWidth = maxWidth - insets.right - insets.left - imageFriends.frame.maxX
        // получаем размеры блока под надпись
        // используем максимальную ширину и максимально возможную высоту
        let textBlock = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        // получаем прямоугольник под текст в этом блоке и уточняем шрифт
        let rect = text.boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        // получаем ширину блока, переводим её в Double
        let width = Double(rect.size.width)
        // получаем высоту блока, переводим её в Double
        let height = Double(rect.size.height)
        // получаем размер, при этом округляем значения до большего целого числа
        let size = CGSize(width: ceil(width), height: ceil(height))
        return size
    }
    
    private func iconViewSize() -> CGSize {
        return CGSize(width: 60, height: 60)
    }
    
    func layoutIconView() {
        let iconSize = iconViewSize()
        let iconOrigin =  CGPoint(x: insets.left, y: insets.top)
        imageFriends.frame = CGRect(origin: iconOrigin, size: iconSize)
    }
    
    private func layoutNameLabel() {
        let nameLabelSize = getLabelSize(text: firstNameLabel.text!, font: firstNameLabel.font, maxWidth: bounds.width)
        let nameLabelOrigin =  CGPoint(x: insets.left + imageFriends.frame.maxX, y: insets.top)
        firstNameLabel.frame = CGRect(origin: nameLabelOrigin, size: nameLabelSize)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIconView()
        layoutNameLabel()
    }
    
}
