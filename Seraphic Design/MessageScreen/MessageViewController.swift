//
//  MessageViewController.swift
//  Seraphic Design
//
//  Created by Shivendra on 12/12/24.
//

import UIKit

class MessageViewController: UIViewController {
    
    @IBOutlet weak var messageCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var messageTextField: UITextField!
    
    private var keyboardHandler: KeyboardHandler?
    private var messageArray = [MessageStruct(message: "next time you'll be awake at this hour why not now", messageType: "Send"),MessageStruct(message: "Didn't I tell you not to put your phone on charge just because it's the weekend?", messageType: "Send"),MessageStruct(message: "next time you'll be awake at this hour why not now", messageType: "Receive"),MessageStruct(message: "Didn't I tell you not to put your phone on charge just because it's the weekend?", messageType: "Receive"), MessageStruct(message: "next time you'll be awake at this hour why not now", messageType: "Send"), MessageStruct(message: "next time you'll be awake at this hour why not now", messageType: "Receive")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        keyboardHandler = KeyboardHandler(scrollView: scrollView)
        keyboardHandler?.registerTextField(messageTextField)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    func setCollectionView() {
        let cellNib = UINib(nibName: "SendCell", bundle: nil)
        let cellNib1 = UINib(nibName: "ReceiveCell", bundle: nil)
        messageCollectionView.register(cellNib, forCellWithReuseIdentifier: "SendCell")
        messageCollectionView.register(cellNib1, forCellWithReuseIdentifier: "ReceiveCell")
        if let layout = messageCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            layout.minimumLineSpacing = 20
            layout.minimumInteritemSpacing = 0
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension MessageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == messageCollectionView {
            return messageArray.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == messageCollectionView {
            if messageArray[indexPath.item].messageType == "Send" {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SendCell", for: indexPath) as! SendCell
                cell.layer.cornerRadius = 18
                cell.messageLabel.text = messageArray[indexPath.item].message
                return cell
            } else if messageArray[indexPath.item].messageType == "Receive" {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReceiveCell", for: indexPath) as! ReceiveCell
                cell.layer.cornerRadius = 18
                cell.messageLabel.text = messageArray[indexPath.item].message
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 0.8
        let textHeight = calculateTextHeight(for: messageArray[indexPath.item].message ?? "", width: width)
        let padding: CGFloat = 20
        let totalHeight = textHeight + padding
        return CGSize(width: collectionView.frame.width - 20, height: totalHeight)
    }

    
    private func calculateTextHeight(for text: String, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: 16)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return ceil(boundingBox.height)
    }
}
