//
//  MainViewController.swift
//  60secs
//
//  Created by Steven Taglohner on 11/02/2018.
//  Copyright © 2018 Steven Taglohner. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
    var seconds = 0
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pauseResumeButton.isEnabled = false
        pauseResumeButton.setTitleColor(.gray, for: .disabled)
        
        setInitialUI()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    @objc func startTimer() {
        runTimer()
        startButton.isEnabled = false
        startButton.setTitleColor(.gray, for: .disabled)
        pauseResumeButton.isEnabled = true
    }
    
    @objc func pauseResume() {
        if self.resumeTapped == false {
            timer.invalidate()
            pauseResumeButton.setTitle("Resume", for: .normal)
            self.resumeTapped = true
        } else {
            runTimer()
            pauseResumeButton.isSelected = false
            pauseResumeButton.setTitle("Pause", for: .normal)
            self.resumeTapped = false
        }
    }
    
    @objc func restartTimer() {
        print("Stop")
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        seconds += 1
        counterLabel.text = "\(seconds)"
    }
    
    /* -------------| VIEW |--------------- */
    
    func setInitialUI() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
    }
    
    let counterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .darkGray
        label.text = "0"
        label.textAlignment = .center
        label.textColor = .green
        label.font = .boldSystemFont(ofSize: 160)
        label.layer.cornerRadius = 150
        label.layer.masksToBounds = true
        return label
    }()
    
    let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.backgroundColor = .green
        button.layer.borderColor = UIColor.green.cgColor
        button.layer.borderWidth = 3
        button.layer.cornerRadius = 40
        button.layer.masksToBounds = true
        return button
    }()
    
    let pauseResumeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Pause", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.backgroundColor = .red
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.borderWidth = 3
        button.layer.cornerRadius = 40
        button.layer.masksToBounds = true
        return button
    }()
    
    let restartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Restart", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.backgroundColor = .blue
        button.layer.borderColor = UIColor.blue.cgColor
        button.layer.borderWidth = 3
        button.layer.cornerRadius = 40
        button.layer.masksToBounds = true
        return button
    }()
    
    func setupViews() {
        
        [counterLabel].forEach { view.addSubview($0) }
        
        let viewsArray = [restartButton, pauseResumeButton, startButton]
        let stackView = UIStackView(arrangedSubviews: viewsArray)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 47.5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        startButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        pauseResumeButton.addTarget(self, action: #selector(pauseResume), for: .touchUpInside)
        restartButton.addTarget(self, action: #selector(restartTimer), for: .touchUpInside)
        
        counterLabel.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: 300, height: 300))
        counterLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        counterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        stackView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 20, right: 20), size: .init(width: 80, height:80))
        
    }
}

