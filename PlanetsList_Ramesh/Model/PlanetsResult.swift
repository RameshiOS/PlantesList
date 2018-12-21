//
//  PlanetsResult.swift
//  PlanetsList_Ramesh
//
//  Created by Ramesh Guddala on 20/12/18.
//  Copyright © 2018 Ramesh. All rights reserved.
//

import Foundation
/**
 * PlanetsResult are getting data from planet service
 *Instantiate the instance using the passed dictionary values to set the properties values
 * Returns all the available property values in the form of [String:Any]
 */

class PlanetsResult : NSObject, NSCoding{
  
    var climate : String!
    var created : String!
    var diameter : String!
    var edited : String!
    var films : [String]!
    var gravity : String!
    var name : String!
    var orbitalPeriod : String!
    var population : String!
    var residents : [String]!
    var rotationPeriod : String!
    var surfaceWater : String!
    var terrain : String!
    var url : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        climate = dictionary["climate"] as? String
        created = dictionary["created"] as? String
        diameter = dictionary["diameter"] as? String
        edited = dictionary["edited"] as? String
        gravity = dictionary["gravity"] as? String
        name = dictionary["name"] as? String
        orbitalPeriod = dictionary["orbital_period"] as? String
        population = dictionary["population"] as? String
        rotationPeriod = dictionary["rotation_period"] as? String
        surfaceWater = dictionary["surface_water"] as? String
        terrain = dictionary["terrain"] as? String
        url = dictionary["url"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if climate != nil{
            dictionary["climate"] = climate
        }
        if created != nil{
            dictionary["created"] = created
        }
        if diameter != nil{
            dictionary["diameter"] = diameter
        }
        if edited != nil{
            dictionary["edited"] = edited
        }
        if gravity != nil{
            dictionary["gravity"] = gravity
        }
        if name != nil{
            dictionary["name"] = name
        }
        if orbitalPeriod != nil{
            dictionary["orbital_period"] = orbitalPeriod
        }
        if population != nil{
            dictionary["population"] = population
        }
        if rotationPeriod != nil{
            dictionary["rotation_period"] = rotationPeriod
        }
        if surfaceWater != nil{
            dictionary["surface_water"] = surfaceWater
        }
        if terrain != nil{
            dictionary["terrain"] = terrain
        }
        if url != nil{
            dictionary["url"] = url
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        climate = aDecoder.decodeObject(forKey: "climate") as? String
        created = aDecoder.decodeObject(forKey: "created") as? String
        diameter = aDecoder.decodeObject(forKey: "diameter") as? String
        edited = aDecoder.decodeObject(forKey: "edited") as? String
        films = aDecoder.decodeObject(forKey: "films") as? [String]
        gravity = aDecoder.decodeObject(forKey: "gravity") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        orbitalPeriod = aDecoder.decodeObject(forKey: "orbital_period") as? String
        population = aDecoder.decodeObject(forKey: "population") as? String
        residents = aDecoder.decodeObject(forKey: "residents") as? [String]
        rotationPeriod = aDecoder.decodeObject(forKey: "rotation_period") as? String
        surfaceWater = aDecoder.decodeObject(forKey: "surface_water") as? String
        terrain = aDecoder.decodeObject(forKey: "terrain") as? String
        url = aDecoder.decodeObject(forKey: "url") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if climate != nil{
            aCoder.encode(climate, forKey: "climate")
        }
        if created != nil{
            aCoder.encode(created, forKey: "created")
        }
        if diameter != nil{
            aCoder.encode(diameter, forKey: "diameter")
        }
        if edited != nil{
            aCoder.encode(edited, forKey: "edited")
        }
        if films != nil{
            aCoder.encode(films, forKey: "films")
        }
        if gravity != nil{
            aCoder.encode(gravity, forKey: "gravity")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if orbitalPeriod != nil{
            aCoder.encode(orbitalPeriod, forKey: "orbital_period")
        }
        if population != nil{
            aCoder.encode(population, forKey: "population")
        }
        if residents != nil{
            aCoder.encode(residents, forKey: "residents")
        }
        if rotationPeriod != nil{
            aCoder.encode(rotationPeriod, forKey: "rotation_period")
        }
        if surfaceWater != nil{
            aCoder.encode(surfaceWater, forKey: "surface_water")
        }
        if terrain != nil{
            aCoder.encode(terrain, forKey: "terrain")
        }
        if url != nil{
            aCoder.encode(url, forKey: "url")
        }
    }
}
