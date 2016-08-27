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
!. David Lowe article on SIFT Keypoints  
[Link](https://www.cs.ubc.ca/~lowe/papers/ijcv04.pdf)
2. Andrew-Ng Machine Learning course from Cousera

##Project coded in Matlab
There are two folders viz. Project-CLI and Project-GUI. You can copy the images from Project-GUI to Project-CLI and start working with the Command Line version of the project.

##Comprehensive Understanding of the project
Firstly, all the images location are loaded in a matrix. Here, we have three categories of images (Thus, three folders inside our ImageCategories Folder). There is a variable named imageSets with three cells (one for each category/folder). Each cell contains Description(name of the folder), Count(no. of images in that particular folder) and Location(location of all the images inside that folder).

Then, using
[VLFEAT library](http://www.vlfeat.org/)
SIFT features were extracted from all the images and stored separately.

Then, all those SIFT features were collected in a variable called features_all and clustered into 500 points using K-Means Clustering

Then, 

##Improvement that can be done


