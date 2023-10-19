# 🏠 DRBS
![DRBS Banner](https://github.com/IERO-6/DRBS-HomeComing/assets/117909631/6e62720a-79ed-49d5-830f-307115467327)

<br>

## 1️⃣ DRBS 소개
복잡한 부동산 체크리스트를 한 번에. 손쉬운 체크리스트 서비스 도라방스

메모장에 따로따로 저장해두어 복잡한 부동산 정보들을 도라방스에서 한번에 정리해보세요.

앱 스토어 : [App Store](https://apps.apple.com/kr/app/%EB%8F%84%EB%9D%BC%EB%B0%A9%EC%8A%A4/id6466733709)

<br>

## 2️⃣ DRBS iOS Developers

|![ryuwon2407](https://avatars.githubusercontent.com/u/95111999?v=4&h=150&w=150)|![kes3035](https://avatars.githubusercontent.com/u/116807969?v=4&h=150&w=150)|![Insuuu24](https://avatars.githubusercontent.com/u/117909631?v=4&h=150&w=150)|![Enoun](https://avatars.githubusercontent.com/u/114083079?v=4&h=150&w=150)|
|:---:|:---:|:---:|:---:|
|[유준호](https://github.com/ryuwon2407)|[김은상](https://github.com/kes3035)|[박인수](https://github.com/Insuuu24)|[김성호](https://github.com/Enoun)|

<br>

## 3️⃣ 개발 환경 및 라이브러리

### 개발 환경

[![UIKit](https://img.shields.io/badge/UIKit-iOS-black.svg?style=square)](https://swift.org) ![Xcode](https://img.shields.io/badge/Xcode-14.3.1-blue) ![swift](https://img.shields.io/badge/swift-5.8.1-orange) ![iOS](https://img.shields.io/badge/iOS-15.0-yellow)

### 라이브러리

| 라이브러리(Library) | 목적(Purpose)            | 버전(Version)                                                |
| ------------------- | ------------------------ | ------------------------------------------------------------ |
| Alamofire           | 서버 통신                | ![Alamofire](https://img.shields.io/badge/Alamofire-5.7.1-orange) |
| SwiftLint          | 깔끔한 코드 컨벤션              | ![SwiftLint](https://img.shields.io/badge/SwiftLint-0.52.4-pink) |
| SnapKit             | 오토레이아웃             | ![SnapKit](https://img.shields.io/badge/SnapKit-5.6.0-skyblue) |
| Then                | 짧은 코드 처리           | ![Then](https://img.shields.io/badge/Then-3.0.0-white) |
| KakaoSDK          | 카카오톡 소셜 로그인     | ![lottie-ios](https://img.shields.io/badge/KakaoSDK-2.0.0-yellow) |

<br>

## 4️⃣  Ground Rule

| 제목        | URL                                                                  |
| ------------ | -------------------------------------------------------------------|
|Code Convention|https://iero.site/Code-Convention-11ebd9e5b3dd411dbf912610e50e7e0c|
|Commit Convention|https://iero.site/Git-Convention-4b46c76a8d5a477c976d54d269c0200d|
|Trouble Shooting|https://iero.site/DRBS-af392606cb8c4c2dac5e704a33efd2bc|

<br>

## 5️⃣ File Structures
```bash
├── DRBS-HomeComing.entitlements
├── 📁 Resources
│   ├── Assets.xcassets
│   └── Font
├── 📁 API
│   └── NetworkingManager.swift
├── 📁 Helpers
│   ├── AppDelegate.swift
│   ├── Constants.swift
│   ├── Extensions.swift
│   ├── Protocols.swift
│   └── SceneDelegate.swift
├── 📁 Model
│   ├── CheckList.swift
│   ├── House.swift
│   └── 📁 SettingSectionModel
│       ├── NoticeList.swift
│       └── SettingSection.swift
├── View
│   ├── 📁 Cell
│   │   ├── 📁 HomeCell
│   │   │   ├── ApartCell.swift
│   │   │   ├── BookMarkCell.swift
│   │   │   ├── HouseTVCell.swift
│   │   │   ├── OneroomCell.swift
│   │   │   └── VillaCell.swift
│   │   ├── DetailCell.swift
│   │   ├── HomeImagesCell.swift
│   │   ├── SearchCell.swift
│   │   └── 📁 SettingSectionCell
│   │       ├── AccountSettingCell.swift
│   │       ├── AppVersionCell.swift
│   │       ├── LisenseCell.swift
│   │       ├── NoticeCell.swift
│   │       ├── NoticeListCell.swift
│   │       └── OptionCell.swift
│   ├── 📁 TV&CV
│   │   ├── DetailVC.swift
│   │   ├── MyHouseImageDetailVC.swift
│   │   └── MyHouseImageVC.swift
│   ├── CategoryNoDataView.swift
│   ├── CustomSlider.swift
│   ├── NoDataView.swift
│   └── 📁 VC
│       ├── 📁 CheckVC
│       │   ├── CalendarVC.swift
│       │   ├── CheckListUIView.swift
│       │   ├── CheckVC1.swift
│       │   ├── CheckVC2.swift
│       │   ├── MyHouseVC.swift
│       │   ├── PopUpVC.swift
│       │   ├── PopUpView.swift
│       │   └── RateVC.swift
│       ├── HomeVC.swift
│       ├── LoginVC.swift
│       ├── 📁 MapVC
│       │   ├── AnnotationView.swift
│       │   ├── MapVC.swift
│       │   ├── ModalVC.swift
│       │   └── SearchVC.swift
│       ├── 📁 SettingSectionVC
│       │   ├── NoticeDetailVC.swift
│       │   ├── NoticeListVC.swift
│       │   ├── SettingVC.swift
│       │   └── WithdrawVC.swift
│       └── Tabbar.swift
└── 📁 ViewModel
│    ├── AuthViewModel.swift
│    ├── CheckViewModel.swift
│    ├── HouseViewModel.swift
│    └── 📁 SettingSectionViewModel
│        ├── NoticeListViewModel.swift
│        └── SettingViewModel.swift
├── GoogleService-Info.plist
├── Info.plist
└── LaunchScreen.storyboard
```

<br>

### 6️⃣ Team Notion
[팀 페이지 바로가기](https://iero.site/)
