//
//  PlanetsRootClass.swift
//  PlanetsList_Ramesh
//
//  Created by Ramesh Guddala on 20/12/18.
//  Copyright © 2018 Ramesh. All rights reserved.
//

import Foundation

/**
 * PlanetsRootClass are getting data from planet service
 *Instantiate the instance using the passed dictionary values to set the properties values
 * Returns all the available property values in the form of [String:Any]
 */
class PlanetsRootClass : NSObject, NSCoding{

    var count : Int!
    var next : String!
    var previous : AnyObject!
    var results : [PlanetsResult]!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        count = dictionary["count"] as? Int
        next = dictionary["next"] as? String
        previous = dictionary["previous"] as? AnyObject
        results = [PlanetsResult]()
        if let resultsArray = dictionary["results"] as? [[String:Any]]{
            for dic in resultsArray{
                let value = PlanetsResult(fromDictionary: dic)
                results.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if count != nil{
            dictionary["count"] = count
        }
        if next != nil{
            dictionary["next"] = next
        }
        if previous != nil{
            dictionary["previous"] = previous
        }
        if results != nil{
            var dictionaryElements = [[String:Any]]()
            for resultsElement in results {
                dictionaryElements.append(resultsElement.toDictionary())
            }
            dictionary["results"] = dictionaryElements
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        count = aDecoder.decodeObject(forKey: "count") as? Int
        next = aDecoder.decodeObject(forKey: "next") as? String
        previous = aDecoder.decodeObject(forKey: "previous") as? AnyObject
        results = aDecoder.decodeObject(forKey: "results") as? [PlanetsResult]
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if count != nil{
            aCoder.encode(count, forKey: "count")
        }
        if next != nil{
            aCoder.encode(next, forKey: "next")
        }
        if previous != nil{
            aCoder.encode(previous, forKey: "previous")
        }
        if results != nil{
            aCoder.encode(results, forKey: "results")
        }
    }
}
