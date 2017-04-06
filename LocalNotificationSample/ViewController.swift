

// Reminder App.
// Created by Adrian Podlesny (- JonesMcJagger)
// Based on LocalNotificationSample, created by Anish on 6/14/16.


import UIKit
import  UserNotifications
import UserNotificationsUI // framework to customize the notification

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    // The following lines define PickerView
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myPicker: UIPickerView!
    
    let pickerData = ["Every minute", "Every 2 minutes", "Every 3 minutes", "Every 4 minutes", "Every 5 minutes", "Every 6 minutes", "Every 7 minutes", "Every 8 minutes", "Every 9 minutes", "Every 10 minutes"]
    var interval: TimeInterval = 60.0 // Assume that row 0 is selected by default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myPicker.delegate = self
        myPicker.dataSource = self
       
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return pickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        myLabel.text = pickerData[row]
        interval = Double(row+1) * 60.0
    }
    
    let requestIdentifier = "SampleRequest" //identifier is to cancel the notification request
    
     /*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    } */
    
    
       @IBAction  func triggerNotification(){
    
        print("notification will be triggered in five seconds..Hold on tight")
        let content = UNMutableNotificationContent()
        // Add your reminder text here:
        content.title = "Hello!"
        content.subtitle = "This is your reminder."
        content.body = "This is some additional info for your reminder."
        content.sound = UNNotificationSound.default()
        
        
        /*
        //To show an image in notification
         
         
        if let path = Bundle.main.path(forResource: "placeholder", ofType: "png") {
            let url = URL(fileURLWithPath: path)
            
            do {
                let attachment = try UNNotificationAttachment(identifier: "sampleImage", url: url, options: nil)
                content.attachments = [attachment]
            } catch {
                print("attachment not found.")
            }
        }
        */
        
        
        // "timeInterval" in the following line is responsible for the time interval between notifications. The value gets defined depending on the selected row, see last 'func PickerView' above.
        
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval:interval, repeats: true)
        let request = UNNotificationRequest(identifier:requestIdentifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().add(request){(error) in
            
            if (error != nil){
                    
                print(error?.localizedDescription ?? "User instance is nil")
                
            }
        }
    }
    
    @IBAction func stopNotification(_ sender: AnyObject) {
        
        print("Removed all pending notifications")
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [requestIdentifier])
        
    }
}

extension ViewController:UNUserNotificationCenterDelegate{
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("Tapped in notification")
    }
    
    // This is key callback to present notification while the app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("Notification being triggered")
        // You can either present alert ,sound or increase badge while the app is in foreground too with ios 10
        // to distinguish between notifications
        if notification.request.identifier == requestIdentifier{
            
            completionHandler( [.alert,.sound,.badge])
            
        }
    }
    
}
