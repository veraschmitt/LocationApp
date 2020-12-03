//
//  SurveyTask.swift
//  1_Trial
//
//  Created by Vera Schmitt on 15.10.20.
//

import Foundation
import ResearchKit
 
public var SurveyTask: ORKOrderedTask {
    
    var steps = [ORKStep]()
    
    
    //Introduction
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "Test Survey"
    instructionStep.text = "Answer two questions to complete the survey."
    steps += [instructionStep]
    
    //Text Input Question
    let nameAnswerFormat = ORKTextAnswerFormat(maximumLength: 20)
    nameAnswerFormat.multipleLines = false
    let nameQuestionStepTitle = "What is your name?"
    let nameQuestionStep = ORKQuestionStep(identifier: "NameStep", title: nameQuestionStepTitle, answer: nameAnswerFormat)
    steps += [nameQuestionStep]
    
        
    //Numeric Input Question
    let ageQuestion = "How old are you?"
    let ageAnswer = ORKNumericAnswerFormat.integerAnswerFormat(withUnit: "years")
    ageAnswer.minimum = 18
    ageAnswer.maximum = 85
    let ageQuestionStep = ORKQuestionStep(identifier: "AgeStep", title: ageQuestion, answer: ageAnswer)
    steps += [ageQuestionStep]
    
        
    //Image Input Question
    let moodQuestion = "How do you feel today?"
    let moodImages = [
        (UIImage(named: "Happy")!, "Happy"),
        (UIImage(named: "Angry")!, "Angry"),
        (UIImage(named: "Sad")!, "Sad"),
        ]
    let moodChoice : [ORKImageChoice] = moodImages.map {
        return ORKImageChoice(normalImage: $0.0, selectedImage: nil, text: $0.1, value: $0.1 as NSCoding & NSCopying & NSObjectProtocol)
    }
    let answerFormat: ORKImageChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(withImageChoices: moodChoice)
    let moodQuestionStep = ORKQuestionStep(identifier: "MoodStep", title: moodQuestion, answer: answerFormat)
    steps += [moodQuestionStep]
        
    //Summary
    let completionStep = ORKCompletionStep(identifier: "SummaryStep")
    completionStep.title = "Thank You!!"
    completionStep.text = "You have completed the survey"
    steps += [completionStep]
    
    return ORKOrderedTask(identifier: "SurveyTask", steps: steps)
}

