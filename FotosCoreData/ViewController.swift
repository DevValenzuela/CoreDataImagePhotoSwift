//
//  ViewController.swift
//  FotosCoreData
//
//  Created by Jorge Maldonado Borbón on 01/09/17.
//  Copyright © 2017 Jorge Maldonado Borbón. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var imagen: UIImageView!
    
    @IBOutlet weak var nombre: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func guardar(_ sender: UIButton) {
        let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let imagenEntity = NSEntityDescription.entity(forEntityName: "Imagenes", in: contexto)
        let newImagen = NSManagedObject(entity: imagenEntity!, insertInto: contexto)
        
        if let imagen = imagen.image {
            let imagenFinal = UIImagePNGRepresentation(imagen) as NSData?
            newImagen.setValue(imagenFinal, forKey: "imagen")
        }
        
        
        newImagen.setValue(nombre.text, forKey: "nombre")
        
        
        do {
            try contexto.save()
            print("guardo")
        } catch let error as NSError {
            print("hubo un error", error)
        }
        
        
    }
    
    @IBAction func camara(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func galeria(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imagenTomada = info[UIImagePickerControllerEditedImage] as? UIImage
        imagen.image = imagenTomada
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    

}

