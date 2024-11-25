# Vocabmate

Vocabmate is an innovative tool designed to enhance your learning experience by leveraging advanced AI technology. With Vocabmate, you can effortlessly convert texts you want to be able to read into flashcards, making studying more efficient and effective.


## Features

- 📁 Upload PDF slides or insert text
- 🧠 Generate up to 150 [Anki](https://apps.ankiweb.net/) flashcards with one click using GPT-4o or GPT-4o-mini by OpenAI
- 📤 Export generated flashcards by Vocabmate to [Anki](https://apps.ankiweb.net/) with CSV file

## How does Vocabmate work?

Vocabmate first detects the input language. It then sends the text to a GPT (chatGPT) model to generate flashcards with AI. The generated flashcards are then displayed in the browser and can be exported to [Anki](https://apps.ankiweb.net/).

## FAQ

### Is the source code of Vocabmate public?
Yes, the source code of the client for Vocabmate is public and can be accessed by anyone interested. You can explore or even contribute to the project by visiting the GitHub repository [lars0530/vocabmate](https://github.com/lars0530/vocabmate). However, it's important to note that while the client's code is open, the backend (including the prompts) is closed source. We greatly value community input and appreciate all contributions to improve Vocabmate. It is also important to note that this project is greatly inspired by [AnkiGPT](https://ankigpt.help/) by Nils Reichardt.

### Which languages are supported?
Vocabmate is designed to be a globally accessible tool, and as such, it supports nearly all languages. This broad language coverage allows users from various linguistic backgrounds to utilize Vocabmate effectively. However, the level of support might vary depending on the language due to complexities in language structures and available datasets. We are consistently working on improving our support for all languages to ensure the best user experience possible.

### Which model is used for Vocabmate?
Vocabmate primarily utilizes the GPT-4o-mini by OpenAI to generate flashcards, offering a seamless integration of advanced AI technology for effective learning. For users who opt for the Vocabmate Plus version, they gain the enhanced capability to generate an increased number of flashcards per month using the more advanced [GPT-4o model](https://openai.com/index/hello-gpt-4o/), ensuring even more sophisticated and nuanced content creation.

### Is the content from my submitted texts used for AI training?
No, your submitted content is not used for AI training. Vocabmate leverages GPT models from OpenAI, which have a strong commitment to user privacy. OpenAI do not use customer-submitted data via their API to train or improve their models (Source: [API data usage policies](https://openai.com/policies/api-data-usage-policies)). Your text content is only processed to create flashcards and is not used for any other purposes, ensuring your information remains private and secure.

### Does Vocabmate work with other flashcard apps than Anki?
Yes! As Vocabmate creates flashcards in CSV-Format, the flashcards can be imported into most known flashcard applications. However, we encourage users to utilize Vocabmate with the [Anki](https://apps.ankiweb.net) app for the best performance and reliability.

### What are the current limitations?
While Vocabmate is a powerful tool, it does have a few limitations to keep in mind:

* Firstly, remember that AI, including Vocabmate, is not infallible. There will be occasional errors in the generated flashcards, as with any AI technology. Always review your flashcards for accuracy.
* Secondly, GPT models, at the current stage of development, aren't able to fully understand every language to the same degree. While Vocabmate supports nearly all languages, the level of support may vary depending on the language.
* Lastly, Vocabmate is continually under development, which means, that some features might not work as expected. Some might also be added or removed without further notice.

We're continually working on refining and expanding Vocabmate's capabilities to improve your learning experience. Stay tuned for future updates and enhancements.

### Is it possible that the flashcards have incorrect information?
Yes, it's possible that the flashcards generated by Vocabmate may contain inaccuracies. Even with its advanced technology, AI is not perfect and can occasionally produce errors. Therefore, Vocabmate should be used as an assistant to your study process, not a replacement for creating your own flashcards. We recommend that users always review and cross-verify the information on the flashcards to ensure accuracy. We're continually working to improve the reliability and precision of our tool, but human oversight remains an important part of the process to guarantee quality learning outcomes.

### Is Vocabmate related to AnkiGPT?
Yes, Vocabmate draws significant inspiration from [AnkiGPT](https://ankigpt.help), a project by [Nils Reichardt](https://www.linkedin.com/in/nilsreichardt). While the frontend of Vocabmate, built using Flutter, shares major similarities with AnkiGPT, the backend infrastructure is entirely developed and maintained independently by Lars Heimann.

### How does Vocabmate work?
Vocabmate is a tool designed to generate flashcards from the text you wish to learn. It leverages the GPT-4o-mini model by OpenAI to create these flashcards. The process is straightforward: you submit the text you want to learn, and Vocabmate generates flashcards based on that content. You can then review and export these flashcards to [Anki](https://apps.ankiweb.net) for further study. Vocabmate aims to streamline the flashcard creation process, making it easier and more efficient for users to learn new information.

On a more technical level, Vocabmate consists of two main components: the frontend and the backend.

**Frontend:**
* Built using [Flutter](https://flutter.dev/), an app development framework by Google, utilizing the [Dart programming language](https://dart.dev/).
* Hosted using AWS Amplify.
* Communicates with the backend for data processing and displays the results.

**Backend:**
* An [Express](https://expressjs.com/) web server developed using [Node.js](https://nodejs.org/en/) of the [Typescript](https://www.typescriptlang.org/) Flavour.
* Containerized and deployed to AWS.
* Hosting:
    * Containers are hosted on AWS infrastructure managed with [OpenTofu](https://opentofu.org/).
    * Infrastructure consists of an ECS cluster with the EC2 launch type, continuously deploying the latest version of the backend to two availability zones.
    * An Elastic Load Balancer distributes requests across instances.

**Networking:**
* The frontend communicates with the backend using a REST API.
* Domains are managed using [Squarespace](https://domains.squarespace.com/de/).

Input on the architecture and design of Vocabmate is always welcome, as we strive to improve the tool and provide the best possible user experience.

## Developing
### Getting Started

1. download dependencies
```bash
flutter pub upgrade
```
2. activate builder
```bash
dart run build_runner watch
```
3. run in chrome browser
```bash
flutter run -d chrome
```
4. make changes
5. hot reload by pressing r in `flutter run`-terminal