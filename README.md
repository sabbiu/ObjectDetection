#ObjectDetection
A starter's guide to Object Detection and Learning

##Scope of the Project

This project classifies three different object categories viz. 
**Coins**
, 
**Keys** 
and 
**Pendrive**
. From the training images it learns all the features of these
 objects. Then, when new test image is given for testing, it identifies them. 
 In case it misinterprets the object with other item, we can always reinforce it and 
 improve our learning model.

##Terms You Need To Know About
```
SIFT  
For feature extraction

K-means Clustering  
For decreasing number of features by creating Bag of Visual Words

SVM Classifier (SMO Optimization)  
For classification of images
```
To get detailed understanding of these topics, I recommend you to go through the followings:  
1. David Lowe's article on [SIFT Keypoints](https://www.cs.ubc.ca/~lowe/papers/ijcv04.pdf)  
2. Andrew-Ng Machine Learning course from Cousera

##Project coded in Matlab 2015b
There are two folders viz. Project-CLI and Project-GUI. You can copy the images from Project-GUI to Project-CLI and start working with the Command Line version of the project.

##Run this project
This project was done in Matlab 2015b.  

**Start with Project-CLI**  
run the scripts as listed below:  
1. object_det_1.m  
2. object_det_2.m  
3. object_det_3.m  
4. object_det_4.m  
Till here your training model will be generated.  
Now, your testing image will be passed for localization and it asks for reinforcement  
5. object_det_5.m  

**Start with Project-GUI**  
run the script:
**objectDetection.m**

##Comprehensive Understanding of the project

Our project can be divided to three different categories:  
1. Training  
2. Testing  
3. Reinforcement Learning  

####Training
Firstly, all the images location are loaded in a matrix. Here, we have three categories of images (Thus, three folders inside our ImageCategories Folder). There is a variable named imageSets with three cells (one for each category/folder). Each cell contains Description(name of the folder), Count(no. of images in that particular folder) and Location(location of all the images inside that folder).

Then, using
[VLFEAT library](http://www.vlfeat.org/),
SIFT descriptors were extracted from all the images and stored separately.

Then, all those SIFT descriptors were collected in a variable called features_all and clustered into 500 clusters using K-Means Clustering. Each cluster is now known as a bag of visual word. Here, the cluster value is saved for testing purposes.

Then, for each image a histogram with these words was formed by counting the number of features that lies in each words. The histogram was then, normalized for making this procedure invariant to number of descriptors used.

Finally, all these normalized histogram were passed to a binary SVM classifier (using one vs all approach to identify different categories of images) and a model for each category was obtained. Hence, the objects were learned.

####Testing
If you are viewing the CLI version, the test image needs to contain four objects in a blank white sheet of paper and all the objects must be placed in its own grid(where, a grid represents a part of that blank white sheet formed after folding it in half vertically and again horizontally).

If you are viewing the GUI version, the test image can contain any number of objects, which cannot touch each other and it must also be in blank white sheet of paper.

Then, the objects are localized by converting it to black and white logical image using graythresh value and finding the connected component. The bounding box was then mapped into our original test image and cropped.

Now, we pass each cropped image to our testing algorithm.

Testing Algorithm first extracts SIFT descriptors from the cropped images, then using the previously saved cluster values, it creates histogram of words, then it normalizes it. It saves the normalized histogram for reinforcement purposes.

Then, it passes the normalized histogram along with all the training model in a loop and gets the scores for each models. It, then compares and finds the maximum score and identifies it as the object.

####Reinforcement Learning
Incase our image is identified incorrectly, in the end, it asks user whether our is image is identified correctly or not. We can write y for correct identification and n for incorrect. When, we say that the image is identified incorrectly, it gives us options to choose from to match the object. It then passes the normalized histogram for those incorrect images and its respective value(choosen/corrected by the user) and adds these features to our new variable called reinf_histogram and saves it to reinf_histogram.mat and generates a new model for each categories again by learning all these new histograms along with previously saved histogram.

##Improvement that can be done
####Localization
For the testing purposes, our objects need to be placed on a blank white sheet of paper. One, can improve this project by improving the localization.
