# movie_assignment

### 1. What is the pattern of state management you are using? And Why?

Provider because the scale and complexity of the app are not large scale and not complex. Provider is a straightforward way to manage state which is more accessible for projects where rapid development is a priority.

Why not BLoC ?
From the requirements, BLoC is a pattern that is designed for separate app into 3 layers Presentation, Business Logic and Data which require more principles than Provider and it is suitable for complex state and business logic.

Why not Riverpod ?
Riverpod is the upgraded version of Provider. Riverpod offering more advanced and flexible state management than Provider. The requirement is a straightforward state management which is Provider and Riverpod can do the same thing but the Provider is simpler.
 
### 2. What is the criteria of choosing a plugin library to use in your work?

This is the way I chose the package.
1. The usage, and capabilities of the package are aligned with the project requirement. 
2. Up to date documentation and Up to date with Flutter and Dart versions.
3. Issues and community. It got an update to fix some issues.
4. Trusted publisher, scores, like or Flutter favorite  

These are some reasons for using packages.
1. HTTP vs DIO
Dio has more advanced methods than HTTP but from the requirement GET method is enough for the requirement.

2. Json annotation and Json serializable
Working with REST API has to deal with JSON to visualize the responses. Json serializable offering generator to/from JSON function by using JSON annotation where to generate the to/from JSON function.

3. envied
The Movie DB requires the API Key or Access token to request the API.  Which needs to secure these sensitive informations.  The envied is more type safety than env because we need to define them within a Dart class and annotate them.

4. cached_network_image
cached_network_image is used to efficiently load and cache images from the internet. Because network images are everywhere in this app. Improving the display network image. 


## Before run and debug the project 
1. Add .env file following .env.example
2. please run the code generator to generate the missing .g.dart generated dart files first.

```
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```
