//
//  QuestionViewController.swift
//  Personality_Quiz_Toure
//“On my honor, I have neither received nor given any unauthorized assistance on Assignment 4 .” Sheick Toure
//  Created by Sheick on 11/19/20.
//

import UIKit

class QuestionViewController: UIViewController {
    
    //interact with the labels and buttons in the questionViewController
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    //determine which outcome each tapped button corresponds to
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        switch sender {
        case singleButton1:
            answersChosen.append(currentAnswers[0])
        case singleButton2:
            answersChosen.append(currentAnswers[1])
        case singleButton3:
            answersChosen.append(currentAnswers[2])
        case singleButton4:
            answersChosen.append(currentAnswers[3])
        default:
            break
            }

        nextQuestion()
    }
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multiLabel1: UILabel!
    @IBOutlet weak var multiLabel2: UILabel!
    @IBOutlet weak var multiLabel3: UILabel!
    @IBOutlet weak var multiLabel4: UILabel!
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    

    //determine which answers to add to the collection based on the switches enabled by the user
    //arguments attribute to None, since you don't need the button to determine which answers were chose
    @IBAction func multipleAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        
        if multiSwitch1.isOn {
            answersChosen.append(currentAnswers[0])
            }
        if multiSwitch2.isOn {
            answersChosen.append(currentAnswers[1])
            }
        if multiSwitch3.isOn {
            answersChosen.append(currentAnswers[2])
            }
        if multiSwitch4.isOn {
            answersChosen.append(currentAnswers[3])
            }
        
            nextQuestion()
    
    }
   
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!
    
    
    //determine which answer to add to the collection by using the current position of the slider
    //arguments attribute to None, since you don't need the button to determine which answers were chose
    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(rangedSlider.value *
            Float(currentAnswers.count - 1)))
            answersChosen.append(currentAnswers[index])
        
            nextQuestion()
    }
    
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    
    
    
    
    //variable initialized to keep track of the questions that user answers
    var questionIndex = 0
    
    //initializing an empty collection of answers
    
    var answersChosen: [Answer] = []

    //filling an array with questions
    var questions: [Question] = [
        
        Question(text: "What would you rather spend your day doing?",
                 type:.single,
                 answers: [
                    Answer(text: "Relaxing on the beach", type: .alligator),
                    Answer(text: "Going on a cruise", type: .baldEagle),
                    Answer(text: "Hiking", type: .camel),
                    Answer(text: "Sleeping", type: .lion)
                          ]),
        Question(text: "Which of these things do you relate to?",
                     type: .multiple,
                     answers: [
                        Answer(text: "Volunteer", type: .alligator),
                        Answer(text: "Student", type: .baldEagle),
                        Answer(text: "Employed", type: .camel),
                        Answer(text: "Athlete", type: .lion)
                              ]),
        
        Question(text: "Are you an introvert or extrovert?",
                     type: .ranged,
                     answers: [
                        Answer(text: "Extrovert", type: .alligator),
                        Answer(text: "Somewhat extrovert",
                              type: .baldEagle),
                        Answer(text: "Somewhat introverted",
                              type: .camel),
                        Answer(text: "Introvert", type: .lion)
                             ])
        ]
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as!
                ResultsViewController
                resultsViewController.responses = answersChosen
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    //controls the visibility of the various types of questions
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        navigationItem.title = "Question #\(questionIndex+1)"
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) /
                Float(questions.count)
        
        navigationItem.title = "Question #\(questionIndex+1)"
            questionLabel.text = currentQuestion.text
            questionProgressView.setProgress(totalProgress, animated:
                true)

        switch currentQuestion.type {
            case .single:
                updateSingleStack(using: currentAnswers)
            case .multiple:
                updateMultipleStack(using: currentAnswers)
            case .ranged:
                updateRangedStack(using: currentAnswers)
            }
        
    }
    
    //using .setTitle operator to link each label to an answer for the single answer question
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    
    //method for stack specific controls for multiple answers question
    func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        multiLabel1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLabel3.text = answers[2].text
        multiLabel4.text = answers[3].text
    }
    
    //used the first and last properties to handle potential crash
    func updateRangedStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
        
    }
    
    func nextQuestion() {
        questionIndex += 1
    
        if questionIndex < questions.count {
            updateUI()
        } else {
          performSegue(withIdentifier: "ResultsSegue", sender: nil)
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
