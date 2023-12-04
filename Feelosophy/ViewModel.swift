//
//  ViewModel.swift
//  Feelosophy
//
//  Created by Justin Lee on 12/3/23.
//

import Foundation

struct RandomDogImage: Codable {
    // From Homework
    let message: String?
    let status: String?
}

class ViewModel: ObservableObject {
    @Published var imageURLString: String = "" // url of the dog image
    
    init() {
        self.fetchNewDog()
    }
    
    /*
     Fetches an image of a new dog from the dog API via GET request.
     */
    func fetchRandomDogImage() {
        // TODO: Implement
        let urlString: String = "https://dog.ceo/api/breeds/image/random"
        guard let url: URL = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let fetchRandomDogImageTask = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Bad http response code")
                return
            }
            guard let data = data else {
                print("There's no data")
                return
            }
            
            
            let decoder = JSONDecoder()
            guard let result = try?
                    decoder.decode(RandomDogImage.self, from: data) else {
                print("Error decoding data")
                return
            }
            
            guard let fetchedImageURL: String = result.message else {
                print("Aint got image url")
                return
            }
            
            DispatchQueue.main.async{
                self.imageURLString = fetchedImageURL
            }
            }
        fetchRandomDogImageTask.resume()
        }
    
    /*
     Resets dog related parameters and fetches a new dog.
     */
    func fetchNewDog() {
        // TODO: Implement
        DispatchQueue.main.async {
            self.imageURLString = ""
            self.fetchRandomDogImage()
        }
    }
}

