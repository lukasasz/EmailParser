import Cocoa
import TabularData
import CreateML

let data = try DataFrame(contentsOfJSONFile: URL(fileURLWithPath: "./email_text.json"))

let (trainingData, testingData) = data.stratifiedSplit(on: "text", by: 0.8)

let parameters = MLTextClassifier.ModelParameters(
    validation: .split(strategy: .automatic),
    algorithm: .transferLearning(.dynamicEmbedding, revision: 1),
    language: .english
)

let sentenceClassifier = try MLTextClassifier(
    trainingData: trainingData,
    textColumn: "sentence",
    labelColumn: "conclusion",
    parameters: parameters
)

let trainingAccuracy = (1.0 - sentenceClassifier.trainingMetrics.classificationError) * 100

let validationAccuracy = (1.0 - sentenceClassifier.validationMetrics.classificationError) * 100

let evaluationMetrics = sentenceClassifier.evaluation(on: testingData, textColumn: "sentence", labelColumn: "conclusion")

let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError) * 100

let metadata = MLModelMetadata(author: "Lukasz Asztemborski",
                               shortDescription: "Test version of model trained to detect email promotions",
                               version: "1.0")


try sentenceClassifier.write(to: URL(fileURLWithPath: "./EmailParser.mlmodel"),
                              metadata: metadata)
