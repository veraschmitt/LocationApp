//
//  ConsentDocument.swift
//  1_Trial
//
//  Created by Vera Schmitt on 15.10.20.
//

import Foundation
import ResearchKit

    
public var ConsentTask: ORKOrderedTask {
    
    let Document = ORKConsentDocument()
    Document.title = "Test Consent"
    
    let sectionTypes: [ORKConsentSectionType] = [
        .overview,
        .dataGathering,
        .privacy,
        .dataUse,
        .timeCommitment,
        .studySurvey,
        .studyTasks,
        .withdrawing
    ]
    
    let consentSections: [ORKConsentSection] = sectionTypes.map { contentSectionType in
        let consentSection = ORKConsentSection(type: contentSectionType)
        consentSection.summary = "General Information"
        consentSection.content = "This survey will ask you several questions and you will track some of your activities and location information. You can share your personal information in this study in order to improve... You can withdraw your consent anytime."
        return consentSection
    }
    
    Document.sections = consentSections
    Document.addSignature(ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "UserSignature"))
    
    var steps = [ORKStep]()
    
    let instructions = ORKInstructionStep(identifier: "surveyInstructions")
    instructions.title = "We'll ask you a few questions"
    instructions.text = "Please click on NEXT if you have completed to answer each question"

    steps += [instructions]
    
    //Visual Consent
    let visualConsentStep = ORKVisualConsentStep(identifier: "VisualConsent", document: Document)
    steps += [visualConsentStep]
    
    //Signature
    let signature = Document.signatures!.first! as! ORKConsentSignature
    let reviewConsentStep = ORKConsentReviewStep(identifier: "Review", signature: signature, in: Document)
    reviewConsentStep.text = "Review the consent"
    reviewConsentStep.reasonForConsent = "Consent to join the Research Study."
    
    steps += [reviewConsentStep]
    
    //Completion
    let completionStep = ORKCompletionStep(identifier: "CompletionStep")
    completionStep.title = "Welcome"
    completionStep.text = "Thank you for joining this study."
    steps += [completionStep]
    
    return ORKOrderedTask(identifier: "ConsentTask", steps: steps)
}
