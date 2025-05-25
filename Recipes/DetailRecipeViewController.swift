//
//  DetailRecipeViewController.swift
//  Recipes
//
//  Created by student on 13.05.25.
//

import UIKit

class DetailRecipeViewController: UIViewController {
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeDifficultyLabel: UILabel!
    @IBOutlet weak var prepTimeLabel: UILabel!
    @IBOutlet weak var cookTimeLabel: UILabel!
    @IBOutlet weak var servingsLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    
    var recipe: Recipe?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = recipe!.name
        recipeNameLabel.text = recipe!.name
        recipeDifficultyLabel.text = "Difficulty: \(recipe!.difficulty.description)"
        prepTimeLabel.text = "Prep Time: \(recipe!.prepTimeMinutes) minutes"
        cookTimeLabel.text = "Cook Time: \(recipe!.cookTimeMinutes) minutes"
        servingsLabel.text = "Servings: \(recipe!.servings)"
        ingredientsLabel.text = "• " + recipe!.ingredients.joined(separator: "\n• ")
        instructionsLabel.text = "• " + recipe!.instructions.joined(separator: "\n• ")
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: self.recipe!.image)
            DispatchQueue.main.async {
                self.recipeImage.image = UIImage(data: data!)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
