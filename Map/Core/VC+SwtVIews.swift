//
//  VC+SwtVIews.swift
//  Map
//
//  Created by Владимир on 22.02.2023.
//

import SnapKit


extension ViewController {
    
     func setViews() {
        map.addSubview(addAdressBut)
        map.addSubview(searchBut)
        map.addSubview(resetBut)
        addAdressBut.snp.makeConstraints { make in
            make.right.equalTo(-5)
            make.top.equalTo(10)
            make.height.equalTo(70)
            make.width.equalTo(150)
        }
         resetBut.snp.makeConstraints { make in
             make.left.equalTo(20)
             make.bottom.equalTo(-20)
             make.height.equalTo(70)
             make.width.equalTo(100)
         }
         searchBut.snp.makeConstraints { make in
             make.right.equalTo(-5)
             make.bottom.equalTo(-20)
             make.height.equalTo(70)
             make.width.equalTo(150)
         }
    }
    
}
