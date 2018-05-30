//
//  GRLegs.swift
//
//  Created by Mahendra on 29/05/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class GRLegs: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let startLocation = "start_location"
    static let endAddress = "end_address"
    static let endLocation = "end_location"
    static let startAddress = "start_address"
    static let steps = "steps"
    static let distance = "distance"
    static let trafficSpeedEntry = "traffic_speed_entry"
    static let duration = "duration"
    static let viaWaypoint = "via_waypoint"
  }

  // MARK: Properties
  public var startLocation: GRStartLocation?
  public var endAddress: String?
  public var endLocation: GREndLocation?
  public var startAddress: String?
  public var steps: [GRSteps]?
  public var distance: GRDistance?
  public var trafficSpeedEntry: [Any]?
  public var duration: GRDuration?
  public var viaWaypoint: [Any]?

  // MARK: ObjectMapper Initializers
  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  public required init?(map: Map){

  }

  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  public func mapping(map: Map) {
    startLocation <- map[SerializationKeys.startLocation]
    endAddress <- map[SerializationKeys.endAddress]
    endLocation <- map[SerializationKeys.endLocation]
    startAddress <- map[SerializationKeys.startAddress]
    steps <- map[SerializationKeys.steps]
    distance <- map[SerializationKeys.distance]
    trafficSpeedEntry <- map[SerializationKeys.trafficSpeedEntry]
    duration <- map[SerializationKeys.duration]
    viaWaypoint <- map[SerializationKeys.viaWaypoint]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = startLocation { dictionary[SerializationKeys.startLocation] = value.dictionaryRepresentation() }
    if let value = endAddress { dictionary[SerializationKeys.endAddress] = value }
    if let value = endLocation { dictionary[SerializationKeys.endLocation] = value.dictionaryRepresentation() }
    if let value = startAddress { dictionary[SerializationKeys.startAddress] = value }
    if let value = steps { dictionary[SerializationKeys.steps] = value.map { $0.dictionaryRepresentation() } }
    if let value = distance { dictionary[SerializationKeys.distance] = value.dictionaryRepresentation() }
    if let value = trafficSpeedEntry { dictionary[SerializationKeys.trafficSpeedEntry] = value }
    if let value = duration { dictionary[SerializationKeys.duration] = value.dictionaryRepresentation() }
    if let value = viaWaypoint { dictionary[SerializationKeys.viaWaypoint] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.startLocation = aDecoder.decodeObject(forKey: SerializationKeys.startLocation) as? GRStartLocation
    self.endAddress = aDecoder.decodeObject(forKey: SerializationKeys.endAddress) as? String
    self.endLocation = aDecoder.decodeObject(forKey: SerializationKeys.endLocation) as? GREndLocation
    self.startAddress = aDecoder.decodeObject(forKey: SerializationKeys.startAddress) as? String
    self.steps = aDecoder.decodeObject(forKey: SerializationKeys.steps) as? [GRSteps]
    self.distance = aDecoder.decodeObject(forKey: SerializationKeys.distance) as? GRDistance
    self.trafficSpeedEntry = aDecoder.decodeObject(forKey: SerializationKeys.trafficSpeedEntry) as? [Any]
    self.duration = aDecoder.decodeObject(forKey: SerializationKeys.duration) as? GRDuration
    self.viaWaypoint = aDecoder.decodeObject(forKey: SerializationKeys.viaWaypoint) as? [Any]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(startLocation, forKey: SerializationKeys.startLocation)
    aCoder.encode(endAddress, forKey: SerializationKeys.endAddress)
    aCoder.encode(endLocation, forKey: SerializationKeys.endLocation)
    aCoder.encode(startAddress, forKey: SerializationKeys.startAddress)
    aCoder.encode(steps, forKey: SerializationKeys.steps)
    aCoder.encode(distance, forKey: SerializationKeys.distance)
    aCoder.encode(trafficSpeedEntry, forKey: SerializationKeys.trafficSpeedEntry)
    aCoder.encode(duration, forKey: SerializationKeys.duration)
    aCoder.encode(viaWaypoint, forKey: SerializationKeys.viaWaypoint)
  }

}
