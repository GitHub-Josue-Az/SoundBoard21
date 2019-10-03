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
    var audioPlayer : AVAudioPlayer?
    var audioURL : URL?
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            setupRecorder()
        playButton.isEnabled = false
    }
    
    func setupRecorder(){
        
        do{
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSession.Category.playAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            
            //Creando una direcciòn para el archivo audio
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponents = [basePath,"audio.m4a"]
             audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
            
            //Crear opciones para el grabador de audio
            var settings : [String: AnyObject] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC) as AnyObject?
            settings[AVSampleRateKey ] = 44100.0 as AnyObject?
            settings[AVNumberOfChannelsKey]  = 2 as AnyObject?
            
            //Crear el obejto de grabaciones de audio
            audioRecorder = try AVAudioRecorder(url: audioURL!, settings: settings)
            audioRecorder!.prepareToRecord()
        }catch let error as NSError{
            print(error)
        }
        
    }
    
    
    @IBAction func recordTapped(_ sender: Any) {
        
        if audioRecorder!.isRecording{
            
            //Detener grabacion
            audioRecorder?.stop()
            //Cambiar el texto del boton grabar
            recordButton.setTitle("Record", for: .normal)
        }else{
            //Empezar a grabar
            audioRecorder?.record()
            //Cambiar el titulo del boton a detener
            recordButton.setTitle("Stop", for: .normal)
            playButton.isEnabled = true
        }
        
    }
    
    
    @IBAction func playTapped(_ sender: Any) {
        
        do{
            try audioPlayer = AVAudioPlayer(contentsOf: audioURL!)
            audioPlayer!.play()
        } catch{}
        
    }
    
    
    @IBAction func addTapped(_ sender: Any) {
    }
    
    
}
