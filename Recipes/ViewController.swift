//
//  ViewController.swift
//  Recipes
//
//  Created by student on 13.05.25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeDifficultyLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Task {
            do {
                try await fetchInfo()
            } catch {
                print("Could not load info!")
            }
            
        }
    }
    
    func fetchInfo() async throws {
        let url = URL(string: "https://dummyjson.com/recipes")!
        let (data, response) = try await URLSession.shared.data(from: url)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyy-MM-dd"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        if let httpResponse = response as? HTTPURLResponse,
           httpResponse.statusCode == 200,
           let decodedData = try? decoder.decode(RecipeResponse.self, from: data) {
            let randomRecipe = decodedData.recipes[Int.random(in: 0..<decodedData.recipes.count)]
            recipeNameLabel.text = randomRecipe.name
            recipeDifficultyLabel.text = randomRecipe.difficulty
            
            let data = try? Data(contentsOf: randomRecipe.image)
            if let imageData = data {
                recipeImage.image = UIImage(data: imageData)
            }
        }
    }
    
    
    @IBAction func getRandomRecipeButton(_ sender: UIButton) {
        Task {
            do {
                try await fetchInfo()
            } catch {
                print("Could not load info!")
            }
            
        }
    }
}

