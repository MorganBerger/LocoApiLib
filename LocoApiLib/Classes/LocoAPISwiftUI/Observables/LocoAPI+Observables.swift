//
//  LocalsManagerObservable.swift
//  Loco API Test
//
//  Created by Morgan Berger on 11/03/2022.
//

import SwiftUI
import Combine

class LocalsManagerObservable: ObservableObject {
    
    private let networking: TranslationManagerNetworking = NetworkManagerImpl()
    
    @Published var state = State()
    
    struct State {
        var currentLanguage: String = "en"
        var isReady: Bool = false
        var langs: RootLanguages = [:]
    }
    
    var disposeBag = Set<AnyCancellable>()
    
    init() {
        if let value = UserDefaultsManager.getValue(for: .languagesDictionaries) as? RootLanguages {
            updateState(value)
        }
        if let lang = UserDefaultsManager.getValue(for: .currentLanguageCode) as? String {
            changeLanguage(lang)
        }
        
        fetch()
            .sink (
                receiveCompletion: { c in
                    switch c {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                },
                receiveValue: { langs in
                    self.updateState(langs)
                }
            )
            .store(in: &disposeBag)
    }
    
    func updateState(_ langs: RootLanguages) {
        DispatchQueue.main.async {
            LocalsManager.update(langs)
            self.state = State(currentLanguage: self.state.currentLanguage, isReady: true, langs: langs)
        }
    }
    
    func changeLanguage(_ newLang: String) {
        LocalsManager.setLanguage(newLang)
        self.state.currentLanguage = newLang
    }
    
    func fetch() -> AnyPublisher<RootLanguages, LocoApiError> {
        return networking.getAllLocalisables()
            .map { response -> RootLanguages in
                if let dict = response.value as? RootLanguages {
                    return dict
                }
                return [:]
            }
            .eraseToAnyPublisher()
    }
}
