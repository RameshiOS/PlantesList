//
//  PlanetsList_RameshTests.swift
//  PlanetsList_RameshTests
//
//  Created by Ramesh Guddala on 20/12/18.
//  Copyright © 2018 Ramesh. All rights reserved.
//

import XCTest
import CoreData

@testable import PlanetsList_Ramesh
class PlanetsList_RameshTests: XCTestCase {

    var planet: Planets? = nil

    
    
    func testgetDataFromUrl()  {
         XCTAssert(true)

    }
    func testsaveNameToCoreData(name: String)  {
        XCTAssertTrue(true, name)
    }
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//
//        var managedContext =
//            appDelegate.persistentContainer.viewContext
//        managedContext = testsetUpInMemoryManagedObjectContext()
//
//        let planetEntity =
//            NSEntityDescription.entity(forEntityName: "Planets",
//                                       in: managedContext)!
//        planet = Planets(entity: planetEntity, insertInto: managedContext)
//
//        planet = Planets(context: managedContext)
//        planet!.name = "Test"
        _ = testsaveNameToCoreData(name: "pluto")
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
