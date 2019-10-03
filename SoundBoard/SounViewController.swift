//
//  SounViewController.swift
//  SoundBoard
//
//  Created by JosueAlva on 10/2/19.
//  Copyright © 2019 JosueAlva. All rights reserved.
//

import AVFoundation

import UIKit

class SounViewController: UIViewController {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    var audioRecorder :  AVAudioRecorder?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func setupRecorder(){
        
        do{
            let session = AVAudioRecorder.sharedInstance()
            try session.setcategory(AudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            
            //Creando una direcciòn para el archivo audio
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponents = [basePath,"audio.m4a"]
            let audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
            
            //Crear opciones para el grabador de audio
            var settings : [String: AnyObject] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC) as AnyObject?
            settings[AVSampleRateKey ] = 44100.0 as AnyObject?
            settings[AVNumberOfChannelsKey]  = 2 as AnyObject?
            
            //Crear el obejto de grabaciones de audio
            audioRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
            audioRecorder!.prepareToRecord()
        }catch let error as NSError{
            print(error)
        }
        
    }
    
    
    @IBAction func recordTapped(_ sender: Any) {
    }
    
    
    @IBAction func playTapped(_ sender: Any) {
    }
    
    
    @IBAction func addTapped(_ sender: Any) {
    }
    
    
}
