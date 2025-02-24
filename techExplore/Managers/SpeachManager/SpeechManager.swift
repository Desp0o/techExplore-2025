//
//  SpeechManager.swift
//  techExplore
//
//  Created by Despo on 21.02.25.
//
import AVFoundation

final class SpeechManager {
  let speechSynthesizer = AVSpeechSynthesizer()
  
  func speakText(text: String) {
    let speechUtterance = AVSpeechUtterance(string: text)
    speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
    speechUtterance.rate = 0.52
    speechSynthesizer.speak(speechUtterance)
  }
  
  func stopSpeaking() {
    if speechSynthesizer.isSpeaking {
      speechSynthesizer.stopSpeaking(at: .immediate)
    }
  }
}
