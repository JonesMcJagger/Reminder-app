# ap-Reminder-app
Code for a simple iOS app which allows the user to choose a certain time interval in which the program will send a self-repeating local notification.

The app uses UIPickerView from the UIKit to allow users to pick a time interval. 
The default intervals are 1 - 10 minutes, but this is adjustable. 

It also uses UIUserNotification for sending a local notification. Whereas 'repeat' can be set true or false. By default it is set to 'true'.
The text used in the notification is a default text which can be changed.
There's also the possibility to show an image within the notification. This is commented out in the code.
