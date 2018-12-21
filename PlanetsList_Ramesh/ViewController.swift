//
//  ViewController.swift
//  PlanetsList_Ramesh
//
//  Created by Ramesh Guddala on 20/12/18.
//  Copyright © 2018 Ramesh. All rights reserved.
//

import UIKit
import CoreData
/**
 * List the planets data to show in table view in this class
 * The UIViewController class defines the shared behavior that is common to all view controllers. You rarely create instances of the UIViewController class directly. Instead, you subclass UIViewController and add the methods and properties needed to manage the view controller's view hierarchy.
 A view controller’s main responsibilities include the following:
 Updating the contents of the views, usually in response to changes to the underlying data.
 Responding to user interactions with views.
 Resizing views and managing the layout of the overall interface.
 Coordinating with other objects—including other view controllers—in your app.
 */

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    var plantesModel : PlanetsRootClass?
    var planetsNames : [NSManagedObject] = []
    
    @IBOutlet weak var listTableView: UITableView!
    
     let appDelegate = UIApplication.shared.delegate as? AppDelegate
    // 1  create varibale of managed Context
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.getDataFromUrl()
    }
    /**
     #viewWillAppear#:
     This method to get offline data when view before load the data with offlline data
     **Discussion**
     
     This method is called before the view controller's view is about to be added to a view hierarchy and before any animations are configured for showing the view. You can override this method to perform custom tasks associated with displaying the view. For example, you might use this method to change the orientation or style of the status bar to coordinate with the orientation or style of the view being presented. If you override this method, you must call super at some point in your implementation.
     For more information about the how views are added to view hierarchies by a view controller, and the sequence of messages that occur, see Supporting Accessibility.
     
     */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

        let managedContext =
            appDelegate!.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Planets")
        
        //3
        do {
            planetsNames = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
  
    /**
     Get data from URl and Reload Tableview
 **Discussion**
     Get the resluts from service and mapping with model
     1. Use JSONSerialization class to convert JSON to Foundation objects and convert Foundation objects to JSON. to assaign the data in jsonResult
     2. Parse into model
     3. save the data offline using core data
     4. Reloading the table view with that data. Call this method to reload all the data that is used to construct the table, including cells, section headers and footers, index arrays, and so on. For efficiency, the table view redisplays only those rows that are visible. It adjusts offsets if the table shrinks
     */
    func getDataFromUrl()  {
 
        let url = URL(string: "https://swapi.co/api/planets/")
        var request : URLRequest = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) {
            data,response,error in

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    do {
                        if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                         //   print(jsonResult)
                       

                            //Use GCD to invoke the completion handler on the main thread
                            DispatchQueue.main.async() {
                                     self.deleteAllData("Planets")
                                
                                self.plantesModel = PlanetsRootClass.init(fromDictionary: jsonResult as! [String : Any])
                                print(self.plantesModel!.results)
                                for item in self.plantesModel!.results {
                                    if let p_name = item.name {
                                        self.saveNameToCoreData(name :p_name )
                                    }
                                }
                                self.listTableView.delegate = self
                                self.listTableView.dataSource = self
                                self.listTableView.reloadData()
               
                            }
                        }
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                }else{
                    
                }
            }
   
        }
        dataTask.resume()
        
    }
    /**
     **deleteAllData**
      **Discussion**
     If any data already stored in entitiy before adding delete old data .
     When changes are committed, object will be removed from the uniquing tables. If object has not yet been saved to a persistent store, it is simply removed from the receiver
     */
    func deleteAllData(_ entity:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        let dataController = appDelegate?.persistentContainer.viewContext

        do {
            let results = try dataController!.fetch(fetchRequest)

            
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
               dataController!.delete(objectData)
               
        
            }
              self.planetsNames.removeAll()
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
    /**
      **Discussion**
     Save name into core data and its mangedobject array
     1. An NSEntityDescription object is associated with a specific class whose instances are used to represent entries in a persistent store in applications using the Core Data Framework. Minimally, an entity description should have:
     A name
     The name of a managed object class
     (If an entity has no managed object class name, it defaults to NSManagedObject.)
     
    2.  A managed object is associated with an entity description (an instance of NSEntityDescription) that provides metadata about the object
    3. The value for the property identified by keyPath.
    4. Append the data into NSManagedObject
     
     */
    func saveNameToCoreData(name: String) {
        

        let managedContext = appDelegate?.persistentContainer.viewContext

        // 2 create varibale of entity and manged object
        let entity =
            NSEntityDescription.entity(forEntityName: "Planets",
                                       in: managedContext!)!
        
        let planetName = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        // 3 set value in manged object
        planetName.setValue(name, forKeyPath: "name")
        
        // 4 Save in Core data
        do {
            try managedContext!.save()
            self.planetsNames.append(planetName)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - Table view data source
//
    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.planetsNames.count
    }
    
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableCell", for: indexPath)
        let planet = planetsNames[indexPath.row]
        cell.textLabel?.text =   planet.value(forKeyPath: "name") as? String
     
        
        return cell
    }
    

    
    
}

